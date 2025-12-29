/**
 * Email template generator for Fluoverse Recap
 * 
 * This template creates a mobile-first, responsive email that links to
 * the interactive recap experience.
 */

export interface RecapEmailData {
  userName: string;
  year: number;
  totalMinutes: number;
  totalSessions: number;
  topLanguage: string;
  appDeepLink?: string;  // e.g., "fluoverse://recap/123"
  webUrl?: string;       // Fallback web URL if needed
  unsubscribeUrl?: string;
}

export function generateRecapEmailHTML(data: RecapEmailData): string {
  const {
    userName,
    year,
    totalMinutes,
    totalSessions,
    topLanguage,
    appDeepLink,
    webUrl,
    unsubscribeUrl = 'https://fluoverse.com/unsubscribe',
  } = data;

  // Use app deep link if available, otherwise fall back to web URL
  const recapUrl = appDeepLink || webUrl || '#';

  // Format numbers with commas
  const formatNumber = (num: number) => num.toLocaleString();

  return `
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Your Fluoverse ${year} Recap</title>
    <!--[if mso]>
    <style type="text/css">
        body, table, td {font-family: Arial, sans-serif !important;}
    </style>
    <![endif]-->
</head>
<body style="margin: 0; padding: 0; background-color: #f4f4f4; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;">
    <table role="presentation" cellspacing="0" cellpadding="0" border="0" width="100%" style="background-color: #f4f4f4;">
        <tr>
            <td align="center" style="padding: 20px 0;">
                <!-- Main container - mobile-first, max 600px -->
                <table role="presentation" cellspacing="0" cellpadding="0" border="0" width="100%" style="max-width: 600px; margin: 0 auto; background-color: #ffffff;">
                    
                    <!-- Header with gradient background -->
                    <tr>
                        <td style="background: linear-gradient(135deg, #7c3aed 0%, #ec4899 50%, #f97316 100%); padding: 40px 20px; text-align: center;">
                            <h1 style="margin: 0; color: #ffffff; font-size: 48px; font-weight: 900; line-height: 1.2;">${year}</h1>
                            <p style="margin: 10px 0 0; color: #ffffff; font-size: 24px; font-weight: 600;">Your Fluoverse Year</p>
                            <p style="margin: 5px 0 0; color: rgba(255, 255, 255, 0.9); font-size: 18px;">${userName}</p>
                        </td>
                    </tr>

                    <!-- Preview stats -->
                    <tr>
                        <td style="padding: 30px 20px; background-color: #ffffff;">
                            <table role="presentation" cellspacing="0" cellpadding="0" border="0" width="100%">
                                <tr>
                                    <td style="text-align: center; padding: 15px 10px; border-bottom: 1px solid #e5e7eb;">
                                        <div style="font-size: 36px; font-weight: 900; color: #7c3aed; line-height: 1;">${formatNumber(totalMinutes)}</div>
                                        <div style="font-size: 14px; color: #6b7280; margin-top: 5px; text-transform: uppercase; letter-spacing: 0.5px;">Minutes Practiced</div>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: center; padding: 15px 10px; border-bottom: 1px solid #e5e7eb;">
                                        <div style="font-size: 36px; font-weight: 900; color: #ec4899; line-height: 1;">${formatNumber(totalSessions)}</div>
                                        <div style="font-size: 14px; color: #6b7280; margin-top: 5px; text-transform: uppercase; letter-spacing: 0.5px;">Learning Sessions</div>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: center; padding: 15px 10px;">
                                        <div style="font-size: 36px; font-weight: 900; color: #f97316; line-height: 1;">${topLanguage}</div>
                                        <div style="font-size: 14px; color: #6b7280; margin-top: 5px; text-transform: uppercase; letter-spacing: 0.5px;">Top Language</div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>

                    <!-- CTA Button -->
                    <tr>
                        <td style="padding: 30px 20px; text-align: center; background-color: #ffffff;">
                            <table role="presentation" cellspacing="0" cellpadding="0" border="0" align="center">
                                <tr>
                                    <td style="background: linear-gradient(135deg, #7c3aed 0%, #ec4899 100%); border-radius: 50px; padding: 0;">
                                        <a href="${recapUrl}" style="display: inline-block; padding: 16px 40px; color: #ffffff; text-decoration: none; font-size: 18px; font-weight: 600; border-radius: 50px;">
                                            ${appDeepLink ? 'Open in App to View Your Recap →' : 'View Your Full Recap →'}
                                        </a>
                                    </td>
                                </tr>
                            </table>
                            ${webUrl && appDeepLink ? `
                            <p style="margin: 15px 0 0; color: #6b7280; font-size: 14px;">
                                Or <a href="${webUrl}" style="color: #7c3aed; text-decoration: underline;">view on web</a>
                            </p>
                            ` : ''}
                        </td>
                    </tr>

                    <!-- Footer -->
                    <tr>
                        <td style="padding: 20px; text-align: center; background-color: #f9fafb; border-top: 1px solid #e5e7eb;">
                            <p style="margin: 0; color: #6b7280; font-size: 14px; line-height: 1.5;">
                                Thanks for learning with Fluoverse!<br>
                                <a href="${unsubscribeUrl}" style="color: #7c3aed; text-decoration: underline;">Unsubscribe</a>
                            </p>
                        </td>
                    </tr>

                </table>
            </td>
        </tr>
    </table>
</body>
</html>
  `.trim();
}

/**
 * Generate a plain text version for email clients that don't support HTML
 */
export function generateRecapEmailText(data: RecapEmailData): string {
  const {
    userName,
    year,
    totalMinutes,
    totalSessions,
    topLanguage,
    appDeepLink,
    webUrl,
  } = data;

  const recapUrl = appDeepLink || webUrl || '#';

  return `
Your Fluoverse ${year} Recap

Hi ${userName},

Thanks for learning with us this year! Here's a quick preview of your ${year} recap:

Minutes Practiced: ${totalMinutes.toLocaleString()}
Learning Sessions: ${totalSessions.toLocaleString()}
Top Language: ${topLanguage}

View your full interactive recap:
${recapUrl}

Thanks for learning with Fluoverse!
  `.trim();
}

