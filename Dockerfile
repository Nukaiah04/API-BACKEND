FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# ✅ Copy everything (important)
COPY . .

# ✅ Restore using explicit project file
RUN dotnet restore "API-BACKEND.csproj"

# ✅ Publish
RUN dotnet publish "API-BACKEND.csproj" -c Release -o /app/out

# Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

COPY --from=build /app/out ./

EXPOSE 80
ENTRYPOINT ["dotnet", "API-BACKEND.dll"]