# What's New in This App Update?

We've squashed some bugs and made some improvements to make the app run smoother for you! Here's a quick rundown:

### 26/March/2024 (1.0.0+7)

**Improved App Functionality:**

-   **Accurate Attendance Stats**: We fixed an issue where the check-in/out percentage wasn't resetting correctly on the admin dashboard attendance statistics. This ensures you see accurate data.
-   **New Attendance Statistics Design**: The admin dashboard now displays attendance statistics for late, early, and on-time arrivals and departures in a format that matches the attendance log for easier comparison.
-   **Enhanced Attendance Log**: The information displayed on each attendance log card has been improved for better clarity.
-   **Break Tracking Fix**: We resolved an error that caused issues with calculating break status and duration when finishing a break.
-   **Total Working Hours**: The home dashboard now correctly calculates your total working hours.

### 25/March/2024 (1.0.0+6)

**Improved App Functionality:**

-   **Home Staff Record Card**: We've updated how break times are calculated and displayed on the home screen for staff record cards.
-   **New Activation Process**: We've replaced the old activation process with a new and improved one.
-   **Login Screen Updates**: When navigating from onboarding and activation, the login screen will now display your organization's image and name.
-   **New Deactivation Process**: The old deactivation process has been replaced with a new and improved one.
-   **Task Completion**: We fixed an issue where tasks with no progress might incorrectly show as 100% complete.

**Backend Fix:**

-   **Attendance Chart**: We resolved an error that caused attendance charts to display incorrect dates.
-   **Leave Notification**: We've added additional information (payload) to leave notifications for improved functionality.

### 23/March/2024 (1.0.0+5)

**Improved App Functionality:**

-   **Task Completion**: We fixed an issue where tasks might incorrectly show 100% complete when switching to a new month if they were empty.
-   **Attendance Tracking**: We identified a problem where changing your device time could mess up your personal attendance data. This is fixed now!
-   **Task Titles**: We've removed the capitalization formatting from task titles for a cleaner look.
-   **Task Details**: You can now see the date a task was created in its details view.
-   **Organization QR Codes**: Organization QR codes are now encoded for better scanning. (QR codes are those square barcodes you can scan with your phone's camera)
-   **Uploading QR Codes**: You can now upload QR codes directly within the app using the new upload button and function.
-   **Check-in/Out Confirmation**: The option button for check-in/out confirmation has been moved from the Attendance screen to the Settings menu for easier access.

**Backend Fix:**

-   **Leave Cancellation**: We resolved an issue where staff members were unable to cancel leave requests due to a permission error.

### 22/March/2024 (1.0.0+4)

[App - Fixes]

-   Enhancing UIs (WIP).
-   Fix all wrong calculation for summary task and leave.

[Backend - Fixes]

-   Fix wrong date on update summary chart for admin when staff for get to check out yesterday and just check out today.
-   Update prevent from glitch earn point with edit the completed task and complete it again.
-   Update total lateness in summary attendance.
-   Update break time in attendance.
-   Update on staff dashboard.
-   Fix wrong calculation percentage on admin dashboard for attendance static.
