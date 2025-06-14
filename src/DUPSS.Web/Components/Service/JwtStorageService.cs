using System.Collections.Concurrent;

namespace DUPSS.Web.Components.Service
{
    public class JwtStorageService
    {
        private readonly ConcurrentDictionary<string, string> _jwtStore = new();

        public JwtStorageService()
        {
        }

        public void StoreJwt(string circuitId, string jwt)
        {
            if (string.IsNullOrEmpty(circuitId))
            {
                throw new ArgumentException("Circuit ID cannot be null or empty.", nameof(circuitId));
            }
            _jwtStore[circuitId] = jwt;
        }

        public string? GetJwt(string circuitId)
        {
            if (string.IsNullOrEmpty(circuitId))
            {
                Console.WriteLine("No circuit ID provided for JWT retrieval.");
                return null;
            }
            if (!_jwtStore.ContainsKey(circuitId))
            {
                Console.WriteLine($"No JWT found for circuit ID: {circuitId}");
                return null;
            }
            return _jwtStore.TryGetValue(circuitId, out var jwt) ? jwt : null;
        }

        public void RemoveJwt(string circuitId)
        {
            if (!string.IsNullOrEmpty(circuitId))
            {
                _jwtStore.TryRemove(circuitId, out _);
            }
        }

        // This method is no longer needed, but kept for compatibility; it will throw an exception
        public string? GetCurrentCircuitId()
        {
            throw new InvalidOperationException("Circuit ID must be provided explicitly.");
        }
    }
}
