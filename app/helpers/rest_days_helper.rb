module RestDaysHelper
  def calendar_for_with_datepicker_fallback(field_id)
    if Redmine::VERSION::STRING >= "3.3"
      return calendar_for(field_id)
    end

    include_calendar_headers_tags
    content_for(:header_tags) do
      javascript_tag(<<-JS.strip_heredoc)
        // backport of https://redmine.org/projects/redmine/repository/revisions/15375
        (function ( $ ) {
          // detect if native date input is supported
          var nativeDateInputSupported = true;

          var input = document.createElement('input');
          input.setAttribute('type','date');
          if (input.type === 'text') {
            nativeDateInputSupported = false;
          }

          var notADateValue = 'not-a-date';
          input.setAttribute('value', notADateValue);
          if (input.value === notADateValue) {
            nativeDateInputSupported = false;
          }

          $.fn.datepickerFallback = function( options ) {
            if (nativeDateInputSupported) {
              return this;
            } else {
              return this.datepicker( options );
            }
          };
        }( jQuery ));
      JS
    end
    javascript_tag("$(function() { $('##{field_id}').addClass('date').datepickerFallback(datepickerOptions); });")
  end
end
