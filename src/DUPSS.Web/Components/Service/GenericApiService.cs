namespace DUPSS.Web.Components.Service
{
    public class GenericApiService<T> where T : class
    {
        private readonly HttpClient _httpClient;
        private readonly string _endpoint;
        private readonly AuthService _authService;

        public GenericApiService(HttpClient httpClient, string endpoint, AuthService authService)
        {
            _httpClient = httpClient;
            _endpoint = endpoint.TrimEnd('/');
            _authService = authService;
        }

        public async Task<List<T>> GetAllAsync()
        {
            await AddAuthorizationHeader();
            var result = await _httpClient.GetFromJsonAsync<List<T>>($"{_endpoint}/GetAll");
            return result ?? new List<T>();
        }

        public async Task<T?> GetByIdAsync(string id)
        {
            await AddAuthorizationHeader();
            return await _httpClient.GetFromJsonAsync<T>($"{_endpoint}/GetById/{id}");
        }

        public async Task<T?> CreateAsync(T entity)
        {
            await AddAuthorizationHeader();
            var response = await _httpClient.PostAsJsonAsync($"{_endpoint}/Create", entity);
            if (response.IsSuccessStatusCode)
            {
                return await response.Content.ReadFromJsonAsync<T>();
            }
            return null;
        }

        public async Task<T?> UpdateAsync(T entity)
        {
            await AddAuthorizationHeader();
            var response = await _httpClient.PutAsJsonAsync($"{_endpoint}/Update", entity);
            if (response.IsSuccessStatusCode)
            {
                return await response.Content.ReadFromJsonAsync<T>();
            }
            return null;
        }

        public async Task<bool> DeleteAsync(string id)
        {
            await AddAuthorizationHeader();
            var response = await _httpClient.DeleteAsync($"{_endpoint}/Delete/{id}");
            return response.IsSuccessStatusCode;
        }

        private async Task AddAuthorizationHeader()
        {
            var token = _authService.GetToken();
            if (!string.IsNullOrEmpty(token))
            {
                _httpClient.DefaultRequestHeaders.Authorization =
                    new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            }
            else
            {
                _httpClient.DefaultRequestHeaders.Authorization = null;
            }
        }
    }
}
