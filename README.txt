Mutha Quality Portal - Access Control + WLS + Plant-wise Master Part List

FIRST:
1. Run PORTAL_ACCESS_MASTERPART_AUDIT.sql once in Supabase SQL Editor.
2. Existing Engineering Drawing records are preserved.
3. Admin then opens User Access & Approvals and assigns:
   - role
   - View / Add / Edit for Engineering Drawing
   - View / Add / Edit for WLS
   - View / Add / Edit for Master Part List

MODULES:
- Engineering Drawing Register
- WLS Report Register
- Plant-wise Master Part List
- Admin User Access & Approvals
- Admin Update Audit Log

WHATSAPP:
Each registration stores a mobile/WhatsApp number.
Changes are recorded in portal_audit_log.
The browser can open WhatsApp with a prefilled update message.
Fully automatic outbound WhatsApp requires an approved Meta WhatsApp Business Cloud API or Twilio integration and server-side credentials; do not put those credentials in the browser.
