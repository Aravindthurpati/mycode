# Use the official .NET SDK image as the build environment
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env
WORKDIR /app

# Copy the project file and restore dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy the remaining source code
COPY . .

# Build the application
RUN dotnet publish -c Release -o out

# Use the official ASP.NET Core runtime image for the final image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app

# Copy the published application from the build environment
COPY --from=build-env /app/out .

# Expose the port your application will run on
EXPOSE 80

# Define the command to run your application
ENTRYPOINT ["dotnet", "YourAppName.dll"]
