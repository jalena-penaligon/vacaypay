Assigned Roles
Time Enforcer: Earl
Notetaker: Jalena
Facilitator: Chi
Facilitator notes:

Are there parts of the app that would benefit from things happening in the background? (tasks that take a long time or need to run on a regular basis; nightly, hourly, etc.)
It may be helpful to utilize background workers when a vacation owner updates the participants on a specific activity. For fixed price activities, the price will need to change on all associated user_activity rows, so adding that to a background worker queue would allow the user to not have to wait for those updates to take place before moving on to the next step.

Are there parts of the app that would benefit from breaking away from the request/response cycle by updating the page automatically? (websockets, AJAX, etc.)
-> When a vacation owner is adding/updating participants from their vacation show page, the page should update without refreshing.

Should you cache data to improve page load times?
-> Not that we can think of at this time.

Should this be one big Rails app?
-> Yes, at this time.

How might the schema look?
![schema]('Schema.png')

Is there anything different you might need to try in your schema? (self-referential associations, serialized columns, etc.)
-> Not at this time.
