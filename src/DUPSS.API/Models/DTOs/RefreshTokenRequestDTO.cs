﻿namespace DUPSS.API.Models.DTOs
{
    public class RefreshTokenRequestDTO
    {
        public required string UserId { get; set; }
        public required string RefreshToken { get; set; }
    }
}
