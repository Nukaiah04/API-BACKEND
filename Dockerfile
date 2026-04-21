FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

COPY . .

RUN ls -R   # 🔥 VERY IMPORTANT DEBUG

# 👉 CHANGE this to your real folder name
WORKDIR /app/API-BACKEND

RUN dotnet restore
RUN dotnet publish -c Release -o /app/out

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

COPY --from=build /app/out ./

EXPOSE 80
ENTRYPOINT ["dotnet", "API-BACKEND.dll"]