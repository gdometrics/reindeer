FactoryGirl.define do
  factory :coach_permission_group, class: PermissionGroup do
    title "Coach"
    pinned_survey_group_titles ["test"]
  end

  factory :student_permission_group, class: PermissionGroup do
    title "Student"
  end
end