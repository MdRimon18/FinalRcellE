using Microsoft.AspNetCore.Http;
using QRCoder;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static System.Net.Mime.MediaTypeNames;
using Image = System.Drawing.Image;

namespace Pms.Helper
{
    public class MediaHelper
    {
        //new UpladMedia Method Created for .net file upload
        //public static string UploadMedia(IFormFile ImageFile,string uploadsFolder)
        //{

        //    var uniqueFileName = Guid.NewGuid().ToString() + "_" + ImageFile.FileName;
        //    var filePath = Path.Combine(uploadsFolder, uniqueFileName);

        //    using (var fileStream = new FileStream(filePath, FileMode.Create))
        //    {
        //        ImageFile.CopyTo(fileStream);
        //    }
        //    return uniqueFileName;
        //}

        public static string UploadOriginalFile(IFormFile file, string urlPath)
        {
            var exten = System.IO.Path.GetExtension(file.FileName);

            if (file.ContentType == "image/png")
            {
                var image = Image.FromStream(file.OpenReadStream());
                var resized = new Bitmap(image);
                using var imageStream = new MemoryStream();
                resized.Save(imageStream, ImageFormat.Png);
                var imageBytes = imageStream.ToArray();
                return UploadFilePng(imageBytes, urlPath);
            }
            else if (file.ContentType == "image/jpeg")
            {
                var image = Image.FromStream(file.OpenReadStream());
                var resized = new Bitmap(image);
                using var imageStream = new MemoryStream();
                resized.Save(imageStream, ImageFormat.Jpeg);
                var imageBytes = imageStream.ToArray();
                return UploadFile(imageBytes, urlPath);
            }
            else
            {
                string fileName = GetFileName(exten);
                string MonthDate = DateTime.UtcNow.ToString("MMMM-yyyy");
                string customUrl = "wwwroot/" + urlPath + "/" + MonthDate + "/";
                string fileUrl = urlPath + "/" + MonthDate + "/";
                var basePath = Path.Combine(Directory.GetCurrentDirectory(), customUrl);
                var path = Path.Combine(Directory.GetCurrentDirectory(), customUrl);
                string destinationPath = Path.Combine(path, file.FileName);
                if (!Directory.Exists(basePath))
                {
                    DirectoryInfo di = Directory.CreateDirectory(basePath);
                }

                using (var stream = new FileStream(destinationPath, FileMode.Create))
                {
                    file.CopyToAsync(stream);
                }

                return fileUrl + file.FileName;
            }
        }
        //public static string UploadLargeFile(IFormFile file, int width, int height, string urlPath)
        //{
        //    var image = Image.FromStream(file.OpenReadStream());
        //    var imageBytes = ResizeImageOriginalRatio(image, width, height);
        //    return UploadFile(imageBytes, urlPath);
        //}
        public static string UploadLargeFile(IFormFile sourceImage, string urlPath)
        {
            string filename = string.Empty;
            System.Drawing.Image souimage =
                System.Drawing.Image.FromStream(sourceImage.OpenReadStream());
            var image = ResizeImageOriginalRatio(souimage, 478, 595);
            filename = UploadFile(image, urlPath);

            return filename;
        }

        public static string UploadMediumFile(IFormFile sourceImage, string urlPath)
        {
            string filename = string.Empty;
            System.Drawing.Image souimage =
                System.Drawing.Image.FromStream(sourceImage.OpenReadStream());
            var image = ResizeImageOriginalRatio(souimage, 368, 349);
            filename = UploadFile(image, urlPath);
            return filename;
        }

        //public static string UploadMediumFile(IFormFile file, int width, int height, string urlPath)
        //{
        //    var image = Image.FromStream(file.OpenReadStream());
        //    var imageBytes = ResizeImageOriginalRatio(image, width, height);
        //    return UploadFile(imageBytes, urlPath);
        //}

        //public static string UploadSmallFile(IFormFile file, int width, int height, string urlPath)
        //{
        //    var image = Image.FromStream(file.OpenReadStream());
        //    var imageBytes = ResizeImageOriginalRatio(image, width, height);
        //    return UploadFile(imageBytes, urlPath);
        //}
        public static string UploadSmallFile(IFormFile sourceImage, string urlPath)
        {
            string fileName = string.Empty;
            System.Drawing.Image souimage =
                System.Drawing.Image.FromStream(sourceImage.OpenReadStream());
            var image = ResizeImageOriginalRatio(souimage, 208, 183);
            fileName = UploadFile(image, urlPath);
            return fileName;
        }
        public static string UploadFile(byte[] imageBytes, string urlPath)
        {

            string filename = string.Empty;
            filename = GetFileName();
            string MonthDate = DateTime.UtcNow.ToString("MMMM-yyyy");
            string customUrl = "wwwroot/" + urlPath + "/" + MonthDate + "/";
            string fileUrl = urlPath + "/" + MonthDate + "/";
            var basePath = Path.Combine(Directory.GetCurrentDirectory(), customUrl);
            var path = Path.Combine(Directory.GetCurrentDirectory(), customUrl, filename);
            if (!Directory.Exists(basePath))
            {
                DirectoryInfo di = Directory.CreateDirectory(basePath);
            }

            using (var stream = new FileStream(path, FileMode.Create, FileAccess.Write, FileShare.Write, 4096))
            {
                stream.Write(imageBytes, 0, imageBytes.Length);
            }

            filename = fileUrl + filename;
            return filename;
        }
        public static string UploadFilePng(byte[] imageBytes, string urlPath)
        {

            string filename = string.Empty;
            filename = GetFileNamepng();
            string MonthDate = DateTime.UtcNow.ToString("MMMM-yyyy");
            string customUrl = "wwwroot/" + urlPath + "/" + MonthDate + "/";
            string fileUrl = urlPath + "/" + MonthDate + "/";
            var basePath = Path.Combine(Directory.GetCurrentDirectory(), customUrl);
            var path = Path.Combine(Directory.GetCurrentDirectory(), customUrl, filename);
            if (!Directory.Exists(basePath))
            {
                DirectoryInfo di = Directory.CreateDirectory(basePath);
            }

            using (var stream = new FileStream(path, FileMode.Create, FileAccess.Write, FileShare.Write, 4096))
            {
                stream.Write(imageBytes, 0, imageBytes.Length);
            }

            filename = fileUrl + filename;
            return filename;
        }
        private static string GetFileNamepng()
        {
            string extension = ".png";
            string fileName = Path.ChangeExtension(
                Path.GetRandomFileName(),
                extension
            );
            return fileName;
        }
        public static byte[] ResizeImageOriginalRatio(Image image, int width, int height)
        {
            //if (image.Width > image.Height)
            //{
            //    width = width > height ? width : height;
            //    height = width < height ? width : height;
            //}
            var resized = new Bitmap(image, new Size(width, height));
            using var imageStream = new MemoryStream();
            resized.Save(imageStream, ImageFormat.Jpeg);
            var imageBytes = imageStream.ToArray();
            return imageBytes;
        }
        private static string GetFileName()
        {
            string extension = ".jpg";
            string fileName = Path.ChangeExtension(
                Path.GetRandomFileName(),
                extension
            );
            return fileName;
        }
        private static string GetFileName(string extension)
        {
            string fileName = Path.ChangeExtension(
                Path.GetRandomFileName(),
                extension
            );
            return fileName;
        }
        public static string GetExtension(string attachment_name)
        {
            var index_point = attachment_name.IndexOf(".") + 1;
            return attachment_name.Substring(index_point);
        }
        public static int DeleteFile(string filePath)
        {
            try
            {

                // Check if the file exists before attempting to delete
                if (File.Exists(filePath))
                {
                    File.Delete(filePath);
                    Console.WriteLine($"File at path '{filePath}' deleted successfully.");
                    return 1;
                }
                else
                {
                    return 0;
                 //   Console.WriteLine($"File at path '{filePath}' does not exist.");
                }
            }
            catch (Exception ex)
            {
                return 0;
            }
        }

        //public static string GenerateQrCode(string text)
        //{

        //    QRCodeData qrCodeData;
        //    using (QRCodeGenerator qrGenerator = new QRCodeGenerator())
        //    {
        //        qrCodeData = qrGenerator.CreateQrCode(text, QRCodeGenerator.ECCLevel.Q);
        //    }
        //  //  var imgType = Base64QRCode.ImageType.Png;
        //   // var qrCode = new Base64QRCode(qrCodeData);
        //   // string qrCodeImageAsBase64 = qrCode.GetGraphic(20, SixLabors.ImageSharp.Color.Black, SixLabors.ImageSharp.Color.White, true, imgType);
        //  //  byte[] imageBytes = Convert.FromBase64String(qrCodeImageAsBase64);
        //   // var image_url = UploadFile(imageBytes, "Content/QrCode");
        //    return image_url;
        //}
    }
}
