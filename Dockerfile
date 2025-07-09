# Build stage
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src

COPY *.sln .
COPY ApiDemo/*.csproj ApiDemo/
RUN dotnet restore

COPY ApiDemo/. ApiDemo/
WORKDIR /src/ApiDemo
RUN dotnet publish -c Release -o /app/publish

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 80
ENTRYPOINT ["dotnet", "ApiDemo.dll"]
