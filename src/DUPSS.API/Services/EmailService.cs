using System.Net;
using System.Net.Mail;
using System.Threading.Tasks;

namespace DUPSS.Web.Components.Service
{
    public class EmailService
    {
        private readonly string smtpHost = "smtp.gmail.com";
        private readonly int smtpPort = 587;
        private readonly string senderEmail = "evanvondeln@gmail.com";        
        private readonly string appPassword = "ooggbjfsdhlnqmvy";          

        public async Task SendEmailAsync(string toEmail, string subject, string body)
        {
            using var smtpClient = new SmtpClient(smtpHost)
            {
                Port = smtpPort,
                Credentials = new NetworkCredential(senderEmail, appPassword),
                EnableSsl = true
            };

            var mailMessage = new MailMessage
            {
                From = new MailAddress(senderEmail, "ALPHA SWP391"), 
                Subject = subject,
                Body = body
            };
            mailMessage.To.Add(toEmail);

            await smtpClient.SendMailAsync(mailMessage);
        }

    }
}
