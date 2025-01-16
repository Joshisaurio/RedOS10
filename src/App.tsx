import { Blocks, Users, Globe, Terminal } from 'lucide-react';
import { FaDiscord } from 'react-icons/fa';
import User from './user'

function App() {
  return (
    <div className="min-h-screen" style={{ backgroundColor: 'rgb(8, 1, 1)' }}>
      {/* Banner */}
      <div
        className="h-[40vh] w-full relative overflow-hidden"
        style={{
          backgroundImage: 'url("https://images.unsplash.com/photo-1451187580459-43490279c0fa?auto=format&fit=crop&w=1920")',
          backgroundSize: 'cover',
          backgroundPosition: 'center',
          backgroundAttachment: 'fixed'
        }}
      >
        <div className="absolute inset-0 bg-gradient-to-b from-transparent via-black/50 to-black" />
      </div>

      {/* Main Content */}
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Profile Section */}
        <div className="-mt-32 relative z-10">
          <div className="flex flex-col items-center">
            {/* Profile Image with glow effect */}
            <div className="relative group">
              <div className="absolute -inset-0.5 bg-red-500 rounded-full blur opacity-75 group-hover:opacity-100 transition duration-1000"></div>
              <div className="relative w-48 h-48 rounded-full border-2 border-gray-700 overflow-hidden bg-gray-800 shadow-2xl">
                <img
                  src="../assets/redos_logo.svg?auto=format&fit=crop&w=400"
                  alt="Team Red OS Logo"
                  className="w-full h-full object-cover transition duration-700 group-hover:scale-110"
                />
              </div>
            </div>

            {/* Team Info */}
            <div className="mt-6 text-center">
              <h1 className="text-5xl font-bold text-red-500">
                Team Red OS
              </h1>
              <p className='text-gray-500 font-bold text-sm'>Gladius Superabit</p>
              <br />
              <p className='bg-clip-text text-transparent bg-gradient-to-r from-[#EF4444] to-[#BC4400] font-bold text-lg'>
                Power and performance unite in Red OS. Our aggressive optimization and cutting-edge architecture make us the force to be reckoned with. Victory runs in our code!
              </p>
            </div>

            {/* Social Links */}
            <div className="flex gap-4 mt-8">
              <a
                href="https://scratch.mit.edu/studios/36154328/"
                target="_blank"
                rel="noopener noreferrer"
                className="flex items-center gap-2 px-6 py-3 bg-gradient-to-r from-orange-400 to-orange-500 rounded-xl hover:translate-y-[-2px] transition-all duration-300 shadow-lg hover:shadow-orange-500/25 text-white"
              >
                <Blocks size={20} />
                <span className="font-medium">Scratch</span>
              </a>
              <a
                href="https://discord.gg/FrXEK2Yq"
                target="_blank"
                rel="noopener noreferrer"
                className="flex items-center gap-2 px-6 py-3 bg-[#5865F2] rounded-xl hover:translate-y-[-2px] transition-all duration-300 shadow-lg hover:shadow-[#5865F2]/25 text-white"
              >
                <FaDiscord size={20} />
                <span className="font-medium">Discord</span>
              </a>
              <a
                href="https://discord.gg/FrXEK2Yq"
                target="_blank"
                rel="noopener noreferrer"
                className="flex items-center gap-2 px-6 py-3 bg-[#EF4444] rounded-xl hover:translate-y-[-2px] transition-all duration-300 shadow-lg hover:shadow-[#5865F2]/25 text-white"
              >
                <Users size={20} />
                <span className="font-medium">Team</span>
              </a>
            </div>
          </div>

        </div>
      </div>

      {/* Team */}
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Profile Section */}
        <div className="relative z-10">
          <div className="flex flex-col items-center">
            {/* Team Info */}
            <div className="mt-6 text-center">
              <h1 className="text-5xl font-bold text-red-500">
                Team
              </h1>

              <div id='leaders'>
                <p className="text-xl text-gray-500 mt-3 font-semibold">Leaders</p>
                <User name='Joshisaurio' scratchLink='https://scratch.mit.edu/users/Joshisaurio/'></User>
                <User name='--Patrixx--' scratchLink='https://scratch.mit.edu/users/--Patrixx--/'></User>
              </div>

              <div id="coders">
                <p className="text-xl text-gray-500 mt-3 font-semibold">Coders</p>
                <User name='CaptainEterk (leader)' scratchLink='https://scratch.mit.edu/users/CaptainEterk/'></User>
                <User name='Enden24' scratchLink='https://scratch.mit.edu/users/enden24/'></User>
                <User name='SpieleTyp' scratchLink='https://scratch.mit.edu/users/SpieleTyp/'></User>
                <User name='Fuzzee_animations' scratchLink='https://scratch.mit.edu/users/Fuzzee_animations/'></User>
                <User name='chez_muffin_boi' scratchLink='https://scratch.mit.edu/users/chez_muffin_boi/'></User>
                <User name='JLCitrus007' scratchLink='https://scratch.mit.edu/users/JLCitrus007/'></User>
                <User name='Alastrantia' scratchLink='https://scratch.mit.edu/users/Alastrantia/'></User>
              </div>
            </div>
          </div>

        </div>
      </div>

      {/* Footer with glassmorphism */}
      <footer className="relative">
        <div className="absolute inset-0 bg-black/30 backdrop-blur-md"></div>
        <div className="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
          <div className="flex flex-col md:flex-row items-center justify-between gap-8">
            <div className="flex items-center gap-4 group">
              <div className="p-3 bg-black/50 rounded-xl border border-gray-700/50 group-hover:border-red-500/50 transition-colors duration-300">
                <Terminal size={32} className="text-red-500" />
              </div>
              <span className="text-2xl font-semibold bg-clip-text text-transparent bg-gradient-to-r from-red-500 to-purple-500">
                OS Wars
              </span>
            </div>
            <div className="flex items-center gap-6">
              <a
                href="https://discord.gg/FrXEK2Yq"
                target="_blank"
                rel="noopener noreferrer"
                className="p-3 text-[#5865F2] hover:text-white bg-black/50 rounded-xl border border-gray-700/50 hover:border-[#5865F2]/50 transition-all duration-300 hover:scale-110"
              >
                <FaDiscord size={24} />
              </a>
              <a
                href="#"
                target="_blank"
                rel="noopener noreferrer"
                className="p-3 text-gray-400 hover:text-white bg-black/50 rounded-xl border border-gray-700/50 hover:border-purple-500/50 transition-all duration-300 hover:scale-110"
              >
                <Globe size={24} />
              </a>
            </div>
          </div>
          <div className="mt-8 text-center">
            <p className="text-gray-400 text-sm">
              Made with <span className="text-red-500">❤️</span> by the{' '}
              <span className="font-medium bg-clip-text text-transparent bg-gradient-to-r from-red-500 to-purple-500">
                OS Wars Team
              </span>
            </p>
          </div>
        </div>
      </footer>
    </div>
  );
}

export default App;