import React, { useState } from 'react';

interface UserProps {
  name: string;
  scratchLink: string;
}

const User: React.FC<UserProps> = ({ name, scratchLink }) => {
  const [isHovered, setIsHovered] = useState(false);

  return (
    <div
      style={{ display: 'block', position: 'relative' }}
      onMouseEnter={() => setIsHovered(true)}
      onMouseLeave={() => setIsHovered(false)}
    >
      <a
        href={scratchLink}
        className={`text-lg font-bold bg-clip-text
          transition-colors duration-250 ease-in-out
          ${isHovered ? 'text-orange-500' : 'text-orange-400'}
        `}
      >
        @{name}
      </a>
    </div>
  );
};

export default User;