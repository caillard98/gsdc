# Start with the official .NET 7 SDK image
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

# Set the working directory to /app
WORKDIR /app

# Copy the .csproj files and restore the NuGet packages
COPY *.csproj .
RUN dotnet restore

# Copy the remaining source code files
COPY . .

# Build the project and publish the output to /app/publish
RUN dotnet publish -c Release -o publish

# Start with the official .NET 7 runtime image
FROM mcr.microsoft.com/dotnet/runtime:7.0 AS final

# Set the working directory to /app
WORKDIR /app

# Copy the published output from the build stage to the current directory
COPY --from=build /app/publish .

# Set the PERIOD_IN_SECONDS environment variable to 60 seconds by default
ENV PERIOD_IN_SECONDS 60

# Start the service with the "dotnet gsdc.dll" command
ENTRYPOINT ["dotnet", "gsdc.dll"]