using Microsoft.AspNetCore.Http;
//using Org.BouncyCastle.Asn1.Crmf;
//using ServiceStack;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static QRCoder.PayloadGenerator.ShadowSocksConfig;
using System.Net.Mail;
using System.Net;
//using RoyexEventManagement.Service.BusinessLayer.Email;
//using RoyexEventManagement.Entity.Models.cus;

namespace RoyexEventManagement.Service.Helper
{
	public class EmailService
	{
		public static void SendEmailWithAttachment(string body,string subject,string senderEmail,  List<string> list)
		{
			try
			{
				// EmailSetupBusiness emailSetupBusiness = new EmailSetupBusiness();
				// var emailSetup = emailSetupBusiness.GetEmailSetup(null,null).Where(t => t.is_default).FirstOrDefault();
				
				MailMessage mailCompany = new MailMessage();

				mailCompany.To.Add(senderEmail);
				//mailCompany.From = new MailAddress(emailSetup.from_email, emailSetup.from_name);

				foreach (var file in list)
				{
					if (file != null)
					{
                  //      string url = WebConfig.BaseUrl + "/" + file;
						var path = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot/" + file);
                        mailCompany.Attachments.Add(new Attachment(path));
					}
				}


				mailCompany.Subject = subject;
				mailCompany.Body = body;
				mailCompany.IsBodyHtml = true;
				mailCompany.Priority = MailPriority.Normal;
				mailCompany.BodyEncoding = System.Text.Encoding.GetEncoding("utf-8");

				SmtpClient clientComapny = new SmtpClient();
				//clientComapny.Host = emailSetup.base_url; 				
				//clientComapny.Credentials = new NetworkCredential(emailSetup.from_email, emailSetup.password);
				clientComapny.EnableSsl = true;
				//clientComapny.Port = emailSetup.port;
				clientComapny.Send(mailCompany);


			}
			catch (Exception ex)
			{

			}

		}
	}
}
