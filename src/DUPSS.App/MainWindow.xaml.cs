using Microsoft.Web.WebView2;
using Microsoft.Web.WebView2.Core;
using System.Text;
using System.Windows;

namespace DUPSS.App
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            LoadBlazorApp();
        }

        private async void LoadBlazorApp()
        {
            await webView.EnsureCoreWebView2Async();
            webView.CoreWebView2.Navigate("https://localhost:7084"); // Your Blazor app URL
        }
    }
}