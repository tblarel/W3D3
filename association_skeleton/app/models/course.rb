class Course < ApplicationRecord
   
  has_many(
    :enrollments,
    class_name: "Enrollment",
    foreign_key: :course_id,
    primary_key: :id
  )
  
  # has_one 
  #   you dont have the foreign key avaliable

  #JOINS
  has_many :enrolled_students,
    through: :enrollments,
    source: :user
  # has_many(
  #   :enrolled_students,
  #   class_name: 'User',    x   
  #   foreign_key: :student_id, 
  #   primary_key: :id       x
  # )

  belongs_to(
    :prerequisite,
    class_name: 'Course', 
    foreign_key: :prereq_id , 
    primary_key: :id       
  )

  belongs_to(
    :instructor,
    class_name: 'User',
    foreign_key: :instructor_id,
    primary_key: :id
  )

end
