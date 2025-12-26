"use client";

import Script from "next/script";

export default function VWO() {
  const VWO_ACCOUNT_ID = process.env.NEXT_PUBLIC_VWO_ACCOUNT_ID;

  // Don't render if VWO Account ID is not provided
  if (!VWO_ACCOUNT_ID) {
    return null;
  }

  // Convert to number for VWO script (it expects a numeric account ID)
  const accountId = parseInt(VWO_ACCOUNT_ID, 10);
  
  if (isNaN(accountId)) {
    console.warn("VWO Account ID must be a valid number");
    return null;
  }

  return (
    <Script
      id="vwo-tracking"
      strategy="afterInteractive"
      dangerouslySetInnerHTML={{
        __html: `
          window._vwo_code = window._vwo_code || (function(){
            var account_id = ${accountId},
            settings_tolerance = 2000,
            library_tolerance = 2500,
            use_existing_jquery = false,
            // DO NOT EDIT BELOW THIS LINE
            f = false, d = document, code = {
              use_existing_jquery: function() { return use_existing_jquery; },
              library_tolerance: function() { return library_tolerance; },
              finish: function() { if (!f) { f = true; var a = d.getElementById('_vis_opt_path_hides'); if (a) a.parentNode.removeChild(a); } },
              finished: function() { return f; },
              load: function(a) { var b = d.createElement('script'); b.src = a; b.type = 'text/javascript'; b.innerText; b.onerror = function() { _vwo_code.finish(); }; d.getElementsByTagName('head')[0].appendChild(b); },
              init: function() {
                window.settings_timer = setTimeout(function() { _vwo_code.finish(); }, settings_tolerance);
                var a = d.createElement('style'), b = 'body{opacity:0 !important;filter:alpha(opacity=0) !important;background:none !important;}', h = d.getElementsByTagName('head')[0];
                a.setAttribute('id', '_vis_opt_path_hides');
                a.setAttribute('type', 'text/css');
                if (a.styleSheet) a.styleSheet.cssText = b; else a.appendChild(d.createTextNode(b));
                h.appendChild(a);
                this.load('https://dev.visualwebsiteoptimizer.com/j.php?a=' + account_id + '&u=' + encodeURIComponent(d.URL) + '&r=' + Math.random());
                return settings_timer;
              }
            };
            window._vwo_settings_timer = code.init();
            return code;
          }());
        `,
      }}
    />
  );
}

