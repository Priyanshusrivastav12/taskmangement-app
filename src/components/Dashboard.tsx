import { useState } from 'react';
import { useAuth } from '../contexts/AuthContext';
import { ItemList } from './ItemList';
import { WeatherWidget } from './WeatherWidget';
import { LogOut, List, Cloud } from 'lucide-react';

export const Dashboard = () => {
  const { user, logout } = useAuth();
  const [activeTab, setActiveTab] = useState<'items' | 'weather'>('items');

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100">
      <nav className="bg-white shadow-md">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between items-center h-16">
            <div className="flex items-center gap-2">
              <h1 className="text-2xl font-bold text-gray-800">MERN App</h1>
            </div>
            <div className="flex items-center gap-4">
              <span className="text-gray-700">Welcome, {user?.name}</span>
              <button
                onClick={logout}
                className="flex items-center gap-2 px-4 py-2 text-gray-700 hover:bg-gray-100 rounded-lg transition-colors"
              >
                <LogOut size={20} />
                Logout
              </button>
            </div>
          </div>
        </div>
      </nav>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="mb-6">
          <div className="flex gap-2 bg-white rounded-lg p-1 shadow-md inline-flex">
            <button
              onClick={() => setActiveTab('items')}
              className={`flex items-center gap-2 px-6 py-2 rounded-md font-medium transition-colors ${
                activeTab === 'items'
                  ? 'bg-blue-600 text-white'
                  : 'text-gray-700 hover:bg-gray-100'
              }`}
            >
              <List size={20} />
              Items
            </button>
            <button
              onClick={() => setActiveTab('weather')}
              className={`flex items-center gap-2 px-6 py-2 rounded-md font-medium transition-colors ${
                activeTab === 'weather'
                  ? 'bg-blue-600 text-white'
                  : 'text-gray-700 hover:bg-gray-100'
              }`}
            >
              <Cloud size={20} />
              Weather
            </button>
          </div>
        </div>

        <div>{activeTab === 'items' ? <ItemList /> : <WeatherWidget />}</div>
      </div>
    </div>
  );
};
