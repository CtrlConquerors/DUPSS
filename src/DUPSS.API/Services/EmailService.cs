using System.Net;
using System.Net.Mail;
using System.Threading.Tasks;

namespace DUPSS.Web.Components.Service
{
    public class EmailService
    {
        private readonly string smtpHost = "smtp.gmail.com";
        private readonly int smtpPort = 587;
        private readonly string senderEmail = "khoipham27052005@gmail.com";        // Thay email thật
        private readonly string appPassword = "qaxqzefpqruuogof";           // Thay App Password

        public async Task SendEmailAsync(string toEmail, string subject, string body)
        {
            using var smtpClient = new SmtpClient(smtpHost)
            {
                Port = smtpPort,
                Credentials = new NetworkCredential(senderEmail, appPassword),
                EnableSsl = true
            };

            var mailMessage = new MailMessage(senderEmail, toEmail, subject, body);
            await smtpClient.SendMailAsync(mailMessage);
        }
    }
}
