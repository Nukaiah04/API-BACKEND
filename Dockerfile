FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# ✅ Copy only csproj first
COPY API-BACKEND.csproj ./

RUN dotnet restore

# ✅ Copy remaining files
COPY . .

RUN dotnet publish -c Release -o /app/out

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

COPY --from=build /app/out ./

EXPOSE 80
ENTRYPOINT ["dotnet", "API-BACKEND.dll"]