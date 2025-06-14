using Microsoft.AspNetCore.Components.Server.Circuits;

namespace DUPSS.Web.Components.Service
{
    public class JwtCircuitHandler : CircuitHandler
    {
        private readonly JwtStorageService _jwtStorageService;
        private readonly CircuitContext _circuitContext;

        public JwtCircuitHandler(JwtStorageService jwtStorageService, CircuitContext circuitContext)
        {
            _jwtStorageService = jwtStorageService;
            _circuitContext = circuitContext;
        }

        public override Task OnCircuitOpenedAsync(Circuit circuit, CancellationToken cancellationToken)
        {
            _circuitContext.CircuitId = circuit.Id;
            Console.WriteLine($"Circuit ID set: {_circuitContext.CircuitId}");
            return base.OnCircuitOpenedAsync(circuit, cancellationToken);
        }

        public override Task OnCircuitClosedAsync(Circuit circuit, CancellationToken cancellationToken)
        {
            _jwtStorageService.RemoveJwt(circuit.Id);
            return base.OnCircuitClosedAsync(circuit, cancellationToken);
        }
    }
}
