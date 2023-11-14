# Use the official .NET Core SDK as a base image
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env

# Set the working directory inside the container
WORKDIR /app

# Copy the project files to the working directory
COPY *.csproj ./

# Restore NuGet packages
RUN dotnet restore

# Copy the remaining files to the working directory
COPY . ./

# Build the application
RUN dotnet publish -c Release -o out

# Use the official .NET Core runtime as the final image
FROM mcr.microsoft.com/dotnet/aspnet:5.0

# Set the working directory inside the container
WORKDIR /app

# Copy the published application from build image
COPY --from=build-env /app/out .

# Expose the port that the application will run on
EXPOSE 80

# Define the command to run the application
ENTRYPOINT ["dotnet", "YourAppName.dll"]
