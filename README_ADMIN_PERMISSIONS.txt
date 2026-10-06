MUTHA QUALITY PORTAL - ADMIN / USER ACTION CONTROL

Advanced Filter:
- Engineering Drawing Register: Advanced Filter across all register fields.
- WLS Report Register: Advanced Filter across all WLS fields.
- Master Part List: Advanced Filter across all product-list fields.
- 3D Scanning DWM & OEE: Advanced Filter across task/date/shift/plant/engineer/customer/part/status fields.
- Quick search + Clear Filters + result count are included.

Action permissions:
ADMIN:
- View
- Add
- Edit
- Delete

NORMAL USER:
- View only when View permission is granted.
- Add only when Add permission is granted.
- Edit only when Edit permission is granted.
- Delete is NOT available to normal users.

Supabase:
Run PORTAL_ADMIN_DELETE_PATCH.sql once to add database-level Admin DELETE policies.
Do not use a service-role key in the browser.
