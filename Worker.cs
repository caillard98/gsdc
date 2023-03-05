using System;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Extensions.Hosting;

namespace gsdc
{
    public class GsdcService : BackgroundService
    {
        private readonly int seconds;

        public GsdcService()
        {
            seconds = int.Parse(Environment.GetEnvironmentVariable("TIMER_PERIOD") ?? "30");
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            while (!stoppingToken.IsCancellationRequested)
            {
                Console.WriteLine($"Task starting at: {DateTime.Now}");


                // Delay next run
                await Task.Delay(TimeSpan.FromSeconds(seconds), stoppingToken);
            }
        }

        public void Start()
        {
            Console.WriteLine($"GsdcService started with a period of {seconds} seconds.");
        }
    }
}
