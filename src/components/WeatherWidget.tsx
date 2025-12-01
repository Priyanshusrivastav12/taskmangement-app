import { useState } from 'react';
import { Cloud, Search } from 'lucide-react';

interface WeatherData {
  location: {
    name: string;
    region: string;
    country: string;
    lat: number;
    lon: number;
    tz_id: string;
    localtime: string;
  };
  current: {
    temp_c: number;
    temp_f: number;
    is_day: number;
    condition: {
      text: string;
      icon: string;
      code: number;
    };
    wind_mph: number;
    wind_kph: number;
    wind_degree: number;
    wind_dir: string;
    pressure_mb: number;
    pressure_in: number;
    precip_mm: number;
    precip_in: number;
    humidity: number;
    cloud: number;
    feelslike_c: number;
    feelslike_f: number;
    vis_km: number;
    vis_miles: number;
    uv: number;
    gust_mph: number;
    gust_kph: number;
  };
}

export const WeatherWidget = () => {
  const [city, setCity] = useState('');
  const [weather, setWeather] = useState<WeatherData | null>(null);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState('');

  const fetchWeather = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!city.trim()) return;

    setIsLoading(true);
    setError('');
    setWeather(null);

    try {
      // Using WeatherAPI.com - a real weather service
      const API_KEY = '1540f61f04e444b8a6a192238250112';
      const response = await fetch(
        `http://api.weatherapi.com/v1/current.json?key=${API_KEY}&q=${encodeURIComponent(city)}&aqi=no`
      );

      if (!response.ok) {
        throw new Error('City not found or API error');
      }

      const data = await response.json();
      setWeather(data);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to fetch weather data');
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="bg-white rounded-lg shadow-xl p-8 max-w-md mx-auto">
      <div className="flex items-center gap-3 mb-6">
        <Cloud size={32} className="text-blue-600" />
        <h2 className="text-2xl font-bold text-gray-800">Weather Info</h2>
      </div>

      <form onSubmit={fetchWeather} className="mb-6">
        <div className="flex gap-2">
          <input
            type="text"
            value={city}
            onChange={(e) => setCity(e.target.value)}
            placeholder="Enter city name"
            className="flex-1 px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
          />
          <button
            type="submit"
            disabled={isLoading}
            className="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition-colors disabled:bg-gray-400"
          >
            <Search size={20} />
          </button>
        </div>
      </form>

      {error && (
        <div className="bg-red-50 border border-red-200 text-red-800 px-4 py-3 rounded mb-4">
          <p className="font-medium">Weather data could not be loaded</p>
          <p className="text-sm mt-1">{error}</p>
        </div>
      )}

      {isLoading && (
        <div className="text-center py-8">
          <div className="inline-block animate-spin rounded-full h-12 w-12 border-4 border-gray-300 border-t-blue-600"></div>
        </div>
      )}

      {weather && (
        <div className="space-y-6">
          {/* Main Weather Display */}
          <div className="text-center bg-gradient-to-br from-blue-50 to-indigo-100 rounded-xl p-6">
            <h3 className="text-3xl font-bold text-gray-800 mb-2">
              {weather.location.name}, {weather.location.region}
            </h3>
            <p className="text-gray-600 mb-4">{weather.location.country}</p>
            
            <div className="flex items-center justify-center gap-4 mb-4">
              <img 
                src={`https:${weather.current.condition.icon}`} 
                alt={weather.current.condition.text}
                className="w-20 h-20"
              />
              <div className="text-left">
                <p className="text-gray-600 capitalize text-lg">{weather.current.condition.text}</p>
                <p className="text-5xl font-bold text-gray-800">{Math.round(weather.current.temp_c)}°C</p>
                <p className="text-gray-600">({Math.round(weather.current.temp_f)}°F)</p>
              </div>
            </div>
            
            <div className="text-sm text-gray-600">
              <p>Local Time: {weather.location.localtime}</p>
              <p>Coordinates: {weather.location.lat}°, {weather.location.lon}°</p>
            </div>
          </div>

          {/* Detailed Weather Information */}
          <div className="grid grid-cols-2 md:grid-cols-3 gap-4">
            <div className="bg-gradient-to-br from-green-50 to-emerald-100 rounded-lg p-4">
              <p className="text-gray-600 text-sm font-medium">Feels Like</p>
              <p className="text-2xl font-bold text-gray-800">{Math.round(weather.current.feelslike_c)}°C</p>
              <p className="text-sm text-gray-500">({Math.round(weather.current.feelslike_f)}°F)</p>
            </div>
            
            <div className="bg-gradient-to-br from-blue-50 to-cyan-100 rounded-lg p-4">
              <p className="text-gray-600 text-sm font-medium">Humidity</p>
              <p className="text-2xl font-bold text-gray-800">{weather.current.humidity}%</p>
              <p className="text-sm text-gray-500">Moisture</p>
            </div>
            
            <div className="bg-gradient-to-br from-yellow-50 to-amber-100 rounded-lg p-4">
              <p className="text-gray-600 text-sm font-medium">Wind Speed</p>
              <p className="text-2xl font-bold text-gray-800">{weather.current.wind_kph} km/h</p>
              <p className="text-sm text-gray-500">{weather.current.wind_dir} ({weather.current.wind_degree}°)</p>
            </div>
            
            <div className="bg-gradient-to-br from-purple-50 to-violet-100 rounded-lg p-4">
              <p className="text-gray-600 text-sm font-medium">Pressure</p>
              <p className="text-2xl font-bold text-gray-800">{weather.current.pressure_mb} mb</p>
              <p className="text-sm text-gray-500">{weather.current.pressure_in} in</p>
            </div>
            
            <div className="bg-gradient-to-br from-indigo-50 to-blue-100 rounded-lg p-4">
              <p className="text-gray-600 text-sm font-medium">Visibility</p>
              <p className="text-2xl font-bold text-gray-800">{weather.current.vis_km} km</p>
              <p className="text-sm text-gray-500">{weather.current.vis_miles} miles</p>
            </div>
            
            <div className="bg-gradient-to-br from-orange-50 to-red-100 rounded-lg p-4">
              <p className="text-gray-600 text-sm font-medium">UV Index</p>
              <p className="text-2xl font-bold text-gray-800">{weather.current.uv}</p>
              <p className="text-sm text-gray-500">{weather.current.uv <= 2 ? 'Low' : weather.current.uv <= 5 ? 'Moderate' : weather.current.uv <= 7 ? 'High' : 'Very High'}</p>
            </div>
            
            <div className="bg-gradient-to-br from-teal-50 to-green-100 rounded-lg p-4">
              <p className="text-gray-600 text-sm font-medium">Cloud Cover</p>
              <p className="text-2xl font-bold text-gray-800">{weather.current.cloud}%</p>
              <p className="text-sm text-gray-500">Cloudiness</p>
            </div>
            
            <div className="bg-gradient-to-br from-gray-50 to-slate-100 rounded-lg p-4">
              <p className="text-gray-600 text-sm font-medium">Wind Gust</p>
              <p className="text-2xl font-bold text-gray-800">{weather.current.gust_kph} km/h</p>
              <p className="text-sm text-gray-500">{weather.current.gust_mph} mph</p>
            </div>
            
            <div className="bg-gradient-to-br from-pink-50 to-rose-100 rounded-lg p-4">
              <p className="text-gray-600 text-sm font-medium">Precipitation</p>
              <p className="text-2xl font-bold text-gray-800">{weather.current.precip_mm} mm</p>
              <p className="text-sm text-gray-500">{weather.current.precip_in} inches</p>
            </div>
          </div>

          {/* Time and Day/Night Info */}
          <div className="bg-gradient-to-r from-slate-100 to-gray-100 rounded-lg p-4">
            <div className="flex justify-between items-center">
              <div>
                <p className="text-gray-600 text-sm">Time Zone</p>
                <p className="font-bold text-gray-800">{weather.location.tz_id}</p>
              </div>
              <div className="text-center">
                <p className="text-gray-600 text-sm">Day/Night</p>
                <p className="font-bold text-gray-800">{weather.current.is_day ? '☀️ Day' : '🌙 Night'}</p>
              </div>
              <div className="text-right">
                <p className="text-gray-600 text-sm">Condition Code</p>
                <p className="font-bold text-gray-800">{weather.current.condition.code}</p>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};
