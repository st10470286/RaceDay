# Entity Relationships & Cardinality

1. **Roles to Users**: 1 to Many (`1:N`) - One role can be assigned to multiple users.
2. **Users to Events**: 1 to Many (`1:N`) - An Organiser can host multiple events.
3. **Events to EventCategories**: 1 to Many (`1:N`) - One event offers multiple distance categories.
4. **Users to EventEnrolments**: 1 to Many (`1:N`) - A Participant can register for multiple events.
5. **EventCategories to EventEnrolments**: 1 to Many (`1:N`) - A category contains multiple participant enrolments.
6. **EventEnrolments to Results**: 1 to 1 (`1:1`) - An enrolment record produces exactly one result entry.
