-- MUTHA QUALITY PORTAL - ADMIN DELETE ACCESS PATCH
-- Run this ONCE in Supabase SQL Editor after the base portal access SQL.
-- Admins can delete register/task records. Normal users retain only their assigned View/Add/Edit permissions.

-- Engineering Drawing Register
DROP POLICY IF EXISTS "Portal admins can delete drawing register" ON public.engineering_drawing_register;
CREATE POLICY "Portal admins can delete drawing register"
ON public.engineering_drawing_register
FOR DELETE TO authenticated
USING (public.is_portal_admin());

-- WLS Report Register
DROP POLICY IF EXISTS "Portal admins can delete WLS reports" ON public.wls_reports;
CREATE POLICY "Portal admins can delete WLS reports"
ON public.wls_reports
FOR DELETE TO authenticated
USING (public.is_portal_admin());

-- Master Part List
DROP POLICY IF EXISTS "Portal admins can delete master part list" ON public.master_part_list;
CREATE POLICY "Portal admins can delete master part list"
ON public.master_part_list
FOR DELETE TO authenticated
USING (public.is_portal_admin());

-- 3D Scanning DWM/OEE tasks
DROP POLICY IF EXISTS "Portal admins can delete scanning tasks" ON public.scanning_tasks;
CREATE POLICY "Portal admins can delete scanning tasks"
ON public.scanning_tasks
FOR DELETE TO authenticated
USING (public.is_portal_admin());

-- Keep the existing audit triggers enabled so deletions are recorded where triggers exist.
