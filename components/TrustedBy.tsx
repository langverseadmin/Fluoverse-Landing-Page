"use client";

import Image from "next/image";

export default function TrustedBy() {
  const partners = [
    {
      name: "ESN Erasmus Student Network Athens AUEB",
      logo: "/ESN.jpg",
      displayName: "ESN",
    },
    {
      name: "GREECE RELOCATION",
      logo: "/Greece_Relocation.png",
      displayName: "GREECE RELOCATION",
    },
    {
      name: "ACE Athens Center for Entrepreneurship",
      logo: "/ACE.png",
      displayName: "ACE",
    },
    {
      name: "THE NET LIFESTYLE",
      logo: "/Net_Lifestyle.jpg",
      displayName: "THE NET LIFESTYLE",
    },
    {
      name: "ORANG GROVE",
      logo: "/orange_grove.webp",
      displayName: "ORANG GROVE",
    },
  ];

  // Duplicate partners for seamless loop - need exact duplicate for seamless animation
  const duplicatedPartners = [...partners, ...partners];

  return (
    <section className="py-16 lg:py-20 overflow-hidden">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center mb-8 lg:mb-12 cursor-default">
          <h3 className="peer text-sm uppercase tracking-[0.2em] text-white/60 font-medium mb-2 transition-all duration-300 hover:text-white/90 inline-block cursor-default select-none">
            Trusted by
          </h3>
          <div className="h-px w-16 bg-gradient-to-r from-transparent via-white/40 to-transparent mx-auto transition-all duration-300 peer-hover:via-white/70 peer-hover:w-24"></div>
        </div>
        <div className="relative py-6">
          {/* Left gradient fade - smooth fade to background */}
          <div 
            className="absolute left-0 top-0 h-full w-20 z-20 pointer-events-none bg-gradient-to-r to-transparent" 
            style={{ backgroundImage: 'linear-gradient(to right, var(--dark-purple-bg), transparent)' }}
          ></div>
          {/* Right gradient fade - smooth fade to background */}
          <div 
            className="absolute right-0 top-0 h-full w-20 md:w-40 z-20 pointer-events-none bg-gradient-to-l to-transparent"
            style={{ backgroundImage: 'linear-gradient(to left, var(--dark-purple-bg), transparent)' }}
          ></div>
          {/* Top border */}
          <div className="absolute left-0 right-0 h-[2px] bg-gradient-to-r from-transparent via-white/30 to-transparent z-20" style={{ top: '0px' }}></div>
          {/* Bottom border */}
          <div className="absolute left-0 right-0 h-[2px] bg-gradient-to-r from-transparent via-white/30 to-transparent z-20" style={{ bottom: '0px' }}></div>
          <div className="overflow-hidden">
            <div className="flex items-center gap-8 lg:gap-12 animate-scroll" style={{ width: 'fit-content' }}>
              {duplicatedPartners.map((partner, index) => (
                <div
                  key={index}
                  className="flex items-center justify-center min-h-[120px] px-4 flex-shrink-0"
                  title={partner.name}
                >
                  <a
                    href="#"
                    className="relative w-[200px] h-[120px] bg-white rounded-lg flex items-center justify-center p-4 group/logo cursor-pointer overflow-hidden"
                    onClick={(e) => {
                      e.preventDefault();
                      // Add your click handler here if needed
                    }}
                  >
                    <Image
                      src={partner.logo}
                      alt={`${partner.name} - Partner organization trusted by Fluoverse`}
                      width={200}
                      height={120}
                      className="object-contain max-h-[100px] max-w-[180px] w-auto h-auto transition-transform duration-300 group-hover/logo:scale-105"
                      onError={(e) => {
                        // Fallback to text if image fails to load
                        const target = e.target as HTMLImageElement;
                        target.style.display = 'none';
                        const parent = target.parentElement;
                        if (parent && !parent.querySelector('.partner-fallback')) {
                          const fallback = document.createElement('span');
                          fallback.className = 'partner-fallback text-white/70 text-sm font-medium text-center whitespace-nowrap';
                          fallback.textContent = partner.displayName;
                          parent.appendChild(fallback);
                        }
                      }}
                    />
                  </a>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}

