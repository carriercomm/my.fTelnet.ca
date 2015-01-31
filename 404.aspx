﻿<%@ Language=C# %>

<script runat="server" language="C#">
    protected void Page_Load(object sender, EventArgs e)
    {
        try {
            System.Net.Mail.MailMessage Msg = new System.Net.Mail.MailMessage("404@ftelnet.ca", "404@ftelnet.ca");
            Msg.Subject = "my.ftelnet.ca 404";
            Msg.Body = "404 on " + Request.Url.AbsoluteUri;
            if (Request.UrlReferrer != null) {
                Msg.Body += "\r\nUrlReferrer: " + Request.UrlReferrer.ToString();
            }
            if (!String.IsNullOrEmpty(Request.UserAgent)) {
                Msg.Body += "\r\nUserAgent: " + Request.UserAgent;
            }
            Msg.IsBodyHtml = false;

            System.Net.Mail.SmtpClient Smtp = new System.Net.Mail.SmtpClient("localhost");
            Smtp.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
            Smtp.Timeout = 10000;
            Smtp.Send(Msg);
        } catch {
            // Ignore
        }
        
        if (Request.Url.AbsoluteUri.ToLower().Contains("/views/") || Request.Url.AbsoluteUri.ToLower().Contains("?hash=")) {
            // Requested an angular view, so return the 404 template
            Response.TransmitFile(Server.MapPath(".\\Views\\404.html"));
        } else {
            // Requested a regular page, so redirect to the angular 404
            Response.Redirect("/#/404");
        }
    }
</script>
