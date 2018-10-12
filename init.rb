# -*- coding: utf-8 -*-

require 'redmine'
require 'redmine_utils_patch'
require 'redmine_work_days/hooks'

ActionDispatch::Callbacks.to_prepare do
  require_dependency 'redmine/utils'

  unless Redmine::Utils::DateCalculation.included_modules.include?(RedmineUtilsDateCalculationPatch)
    Redmine::Utils::DateCalculation.send :include, RedmineUtilsDateCalculationPatch
  end
end

Redmine::Plugin.register :redmine_work_days do
  name 'Redmine Work Days'
  author 'Agileware Inc.'
  description 'This plugin enables to set the holidays.'
  version '1.3.0'
  author_url 'http://agileware.jp'

  menu :admin_menu, :rest_days,
  { :controller => 'rest_days', :action => 'index' },
  :caption => :rest_days,
  :html => { :class => 'icon icon-redmine-work-days'}
end
