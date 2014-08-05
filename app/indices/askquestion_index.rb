ThinkingSphinx::Index.define :askquestion, :with => :active_record do
  indexes title, :sortable => true
  indexes description
  indexes tags.name, as: :tag

  has created_at, updated_at
end