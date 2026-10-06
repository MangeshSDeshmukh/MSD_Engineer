-- Mutha Quality Portal: notify the user who performs a register/task update.
-- This complements profile-update and scanning-assignment notifications.
-- Run after PORTAL_ACCESS_MASTERPART_AUDIT.sql and PORTAL_REGISTRATION_NOTIFICATION_UPGRADE.sql.

CREATE OR REPLACE FUNCTION public.queue_actor_update_notification()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path=public
AS $$
DECLARE
  p public.user_profiles%ROWTYPE;
  rid text;
  label text;
  msg text;
  subj text;
  changed boolean := true;
BEGIN
  IF TG_OP='UPDATE' THEN
    changed := (to_jsonb(NEW) - 'updated_at') IS DISTINCT FROM (to_jsonb(OLD) - 'updated_at');
  END IF;
  IF NOT changed THEN RETURN NEW; END IF;

  SELECT * INTO p FROM public.user_profiles WHERE id=auth.uid();
  IF p.id IS NULL THEN RETURN NEW; END IF;

  rid := coalesce((CASE WHEN TG_OP='DELETE' THEN to_jsonb(OLD) ELSE to_jsonb(NEW) END)->>'id',
                  (CASE WHEN TG_OP='DELETE' THEN to_jsonb(OLD) ELSE to_jsonb(NEW) END)->>'report_no',
                  (CASE WHEN TG_OP='DELETE' THEN to_jsonb(OLD) ELSE to_jsonb(NEW) END)->>'part_no',
                  (CASE WHEN TG_OP='DELETE' THEN to_jsonb(OLD) ELSE to_jsonb(NEW) END)->>'register_no','?');
  label := coalesce((CASE WHEN TG_OP='DELETE' THEN to_jsonb(OLD) ELSE to_jsonb(NEW) END)->>'drawing_no',
                    (CASE WHEN TG_OP='DELETE' THEN to_jsonb(OLD) ELSE to_jsonb(NEW) END)->>'report_no',
                    (CASE WHEN TG_OP='DELETE' THEN to_jsonb(OLD) ELSE to_jsonb(NEW) END)->>'part_no',rid);
  subj := 'Mutha Quality Portal - Update Confirmation';
  msg := 'Portal update recorded: Module '||TG_ARGV[0]||', Action '||TG_OP||', Record '||label||', Updated by '||coalesce(p.employee_name,p.official_email,'User')||' at '||to_char(now(),'DD-Mon-YYYY HH24:MI:SS')||'.';

  IF coalesce(p.email_opt_in,true) AND coalesce(p.official_email,'')<>'' THEN
    INSERT INTO public.portal_notifications(event_type,module,record_id,recipient_user_id,recipient_name,recipient_email,recipient_mobile,channel,subject,message)
    VALUES('PORTAL_UPDATE','update_confirmation',rid,p.id,p.employee_name,p.official_email,p.mobile_no,'EMAIL',subj,msg);
  END IF;
  IF coalesce(p.whatsapp_opt_in,true) AND coalesce(p.mobile_no,'')<>'' THEN
    INSERT INTO public.portal_notifications(event_type,module,record_id,recipient_user_id,recipient_name,recipient_email,recipient_mobile,channel,subject,message)
    VALUES('PORTAL_UPDATE','update_confirmation',rid,p.id,p.employee_name,p.official_email,p.mobile_no,'WHATSAPP',subj,msg);
  END IF;
  RETURN coalesce(NEW,OLD);
END;
$$;

DROP TRIGGER IF EXISTS trg_notify_actor_engineering_drawing ON public.engineering_drawing_register;
CREATE TRIGGER trg_notify_actor_engineering_drawing AFTER INSERT OR UPDATE OR DELETE ON public.engineering_drawing_register
FOR EACH ROW EXECUTE FUNCTION public.queue_actor_update_notification('engineering_drawing');

DROP TRIGGER IF EXISTS trg_notify_actor_wls ON public.wls_reports;
CREATE TRIGGER trg_notify_actor_wls AFTER INSERT OR UPDATE OR DELETE ON public.wls_reports
FOR EACH ROW EXECUTE FUNCTION public.queue_actor_update_notification('wls');

DROP TRIGGER IF EXISTS trg_notify_actor_master_part ON public.master_part_list;
CREATE TRIGGER trg_notify_actor_master_part AFTER INSERT OR UPDATE OR DELETE ON public.master_part_list
FOR EACH ROW EXECUTE FUNCTION public.queue_actor_update_notification('master_part');

DROP TRIGGER IF EXISTS trg_notify_actor_scanning_tasks ON public.scanning_tasks;
CREATE TRIGGER trg_notify_actor_scanning_tasks AFTER INSERT OR UPDATE OR DELETE ON public.scanning_tasks
FOR EACH ROW EXECUTE FUNCTION public.queue_actor_update_notification('scanning_dwm');

CREATE INDEX IF NOT EXISTS idx_portal_notifications_event ON public.portal_notifications(event_type,created_at);
