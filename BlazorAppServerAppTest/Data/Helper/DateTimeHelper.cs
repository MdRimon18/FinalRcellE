﻿namespace Pms.Helper
{
    public class DateTimeHelper
    {
        private static readonly DateTime Jan1st1970 = new DateTime
     (1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);
        public static long CurrentTimeMillis(DateTime dateTime)
        {
            //-8 for server
            return (long)(dateTime - Jan1st1970).TotalMilliseconds;
        }

        public static String DateFormat(DateTime receivedate)
        {
            return receivedate.ToString("MMMM dd, yyyy");
        }

        public static String DateFormat_mmddyyy(DateTime receivedate)
        {
            return receivedate.ToString("MM/dd/yyyy");
        }


        public static DateTime DubaiTime()
        {
            var timeZoneInfo = TimeZoneInfo.FindSystemTimeZoneById("Arabian Standard Time");
            DateTime dateTime = TimeZoneInfo.ConvertTime(DateTime.Now, timeZoneInfo);
            return dateTime;
        }
        public static DateTime CurrentDateTime()
        {
            DateTime dateTime= DateTime.Now;
            //here date time will be return according to Country 
            if("Bangladesh"== "Bangladesh")
            {
                var timeZoneInfo = TimeZoneInfo.FindSystemTimeZoneById("Bangladesh Standard Time");
                dateTime = TimeZoneInfo.ConvertTime(DateTime.Now, timeZoneInfo);
            }

            return dateTime;
        }

    }
}
