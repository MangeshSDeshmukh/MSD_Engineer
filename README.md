# Mutha Quality Portal — Master Part + 3D Scanning DWM/OEE Upgrade

## Your two uploaded source files are used as separate modules

### 1. Plant-wise Master Part List
Source: `MUTHA GROUP Product List 2023.xlsx`

The product-list sheets are normalized into `master_part_list_import.csv` for portal import. The portal keeps plant-wise information and the WLS item code, short name, part number, description, customer, material, frequency, active status, plan quantities, dispatch type and core-related information.

### 2. 3D Scanning DWM & OEE
Source: `3D_Scanning_Register-2025 2.xls`

The historical register is normalized into `3d_scanning_register_2025_import.csv`. This is NOT the WLS Report Register. It is the historical daily-work source for the new scanning DWM module.

## New 3D Scanning DWM/OEE module

- Two working shifts: Shift A and Shift B
- Plant/unit-wise planning
- Scanning-engineer master
- Engineer-wise task assignment
- Daily task board
- Priority: Low / Medium / High
- Work type and work details
- Planned minutes
- Actual minutes
- Downtime minutes
- Task status: Assigned / In Progress / On Hold / Completed / Cancelled
- Final result: OK / NG / Approved / Rejected
- Report number and report-sent status
- Observation / abnormality / remarks
- Engineer-wise, shift-wise and plant-wise KPI
- OEE-style KPI = Availability × Performance × Quality

### OEE calculation used
- Availability = (Planned Minutes − Downtime) / Planned Minutes
- Performance = Planned Minutes / Actual Minutes, capped at 100%
- Quality = OK/Approved completed tasks / completed tasks
- OEE = Availability × Performance × Quality

## Admin permissions
Admin can control access independently for:

- Engineering Drawing Register
- WLS Report Register
- Plant-wise Master Part List
- 3D Scanning DWM & OEE

For every module: **View / Add / Edit**.

Admin can also approve/reject users and assign their role.

## Supabase setup order

1. Run the existing `PORTAL_ACCESS_MASTERPART_AUDIT.sql` from the previous package.
2. Run `SCANNING_DWM_OEE_UPGRADE.sql`.
3. Import `master_part_list_import.csv` into `public.master_part_list`.
4. Import `3d_scanning_register_2025_import.csv` into `public.scanning_register_history` if historical records are required in the portal.
5. Open the updated webpage and use **User Access & Approvals** to give users access.
6. In **3D Scanning DWM & OEE → Manage Engineers**, select the approved users who are scanning engineers and assign their default plant and shift.
7. Use **Assign Scanning Task** for daily DWM.

## WhatsApp

The portal can prepare an update message using the registered WhatsApp/mobile number. Fully automatic outbound WhatsApp requires a WhatsApp Business Cloud API or Twilio integration. API credentials should be kept server-side and never embedded in browser JavaScript.
