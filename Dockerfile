#-- tài image => kiểu như cài netcore lên máy 
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base 
WORKDIR /app 
EXPOSE 80 
# Base image chỉ để chạy (runtime) 
FROM mcr.microsoft.com/dotnet/aspnet:8.0 
WORKDIR /app 
# Stage 1: build 
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src 
COPY ["testCDproject/testCDproject.csproj","src/"] 
RUN dotnet restore "src/testCDproject.csproj" 
COPY . . 
WORKDIR /src 
RUN dotnet build "testCDproject.csproj" -c Release  -o /app/build 
FROM build AS publish 
RUN dotnet publish "testCDproject.csproj" -c Release -o /app/publish /p:UseAppHost=false 
# Stage 2: runtime 
FROM base AS final 
WORKDIR /app 
COPY --from=publish /app/publish . 
ENTRYPOINT ["dotnet", "testCDproject.dll"] 