module RedmineWorkDays
  class Hooks < Redmine::Hook::ViewListener
    def view_layouts_base_html_head(*)
      stylesheet_link_tag 'redmine_work_days', plugin: 'redmine_work_days'
    end
  end
end
