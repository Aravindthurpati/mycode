FROM mcr.microsoft.com/dotnet:5.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet:5.0-sdk AS build-env
WORKDIR /src

# Copy only the .csproj file and restore as distinct layers
COPY *.csproj .
RUN dotnet restore

# Copy everything else and build
COPY . .
RUN dotnet publish -c Release -o out

FROM base AS final
WORKDIR /app
COPY --from=build-env /src/out .
EXPOSE 80
ENTRYPOINT ["dotnet", "YourAppName.dll"]
