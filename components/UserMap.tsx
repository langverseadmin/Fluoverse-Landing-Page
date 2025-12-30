"use client";

import { motion } from "framer-motion";
import { useState, useEffect } from "react";
import {
  ComposableMap,
  Geographies,
  Geography,
  Marker,
} from "react-simple-maps";

// World map topojson URL
const geoUrl = "https://cdn.jsdelivr.net/npm/world-atlas@2/countries-110m.json";

// Countries with users and their coordinates [longitude, latitude]
const countryMarkers: Array<{ name: string; coordinates: [number, number] }> = [
  { name: "United States", coordinates: [-95.7129, 37.0902] },
  { name: "United Kingdom", coordinates: [-3.4360, 55.3781] },
  { name: "France", coordinates: [2.2137, 46.2276] },
  { name: "Germany", coordinates: [10.4515, 51.1657] },
  { name: "Japan", coordinates: [138.2529, 36.2048] },
  { name: "Australia", coordinates: [133.7751, -25.2744] },
  { name: "Brazil", coordinates: [-51.9253, -14.2350] },
  { name: "Mexico", coordinates: [-102.5528, 23.6345] },
  { name: "India", coordinates: [78.9629, 20.5937] },
  { name: "China", coordinates: [104.1954, 35.8617] },
  { name: "Spain", coordinates: [-3.7492, 40.4637] },
  { name: "Italy", coordinates: [12.5674, 41.8719] },
  { name: "Canada", coordinates: [-106.3468, 56.1304] },
  { name: "Singapore", coordinates: [103.8198, 1.3521] },
  { name: "Sweden", coordinates: [18.6435, 60.1282] },
  { name: "Netherlands", coordinates: [5.2913, 52.1326] },
  { name: "Belgium", coordinates: [4.4699, 50.5039] },
  { name: "Argentina", coordinates: [-63.6167, -38.4161] },
  { name: "United Arab Emirates", coordinates: [53.8478, 23.4241] },
  { name: "Greece", coordinates: [21.8243, 39.0742] },
  { name: "Egypt", coordinates: [30.8025, 26.0975] },
  { name: "Russia", coordinates: [105.3188, 61.5240] },
  { name: "Poland", coordinates: [19.1451, 51.9194] },
  { name: "Turkey", coordinates: [35.2433, 38.9637] },
  { name: "Portugal", coordinates: [-8.2245, 39.3999] },
  { name: "Israel", coordinates: [34.8516, 31.0461] },
  { name: "South Africa", coordinates: [22.9375, -30.5595] },
  { name: "Nigeria", coordinates: [8.6753, 9.0820] },
];

export default function UserMap() {
  const [selectedMarker, setSelectedMarker] = useState<number | null>(null);
  const [isMobile, setIsMobile] = useState(false);

  useEffect(() => {
    const checkMobile = () => {
      setIsMobile(window.innerWidth < 640);
    };
    checkMobile();
    window.addEventListener("resize", checkMobile);
    return () => window.removeEventListener("resize", checkMobile);
  }, []);

  return (
    <div className="relative w-full max-w-5xl mx-auto">
      <motion.div
        initial={{ opacity: 0, scale: 0.95 }}
        whileInView={{ opacity: 1, scale: 1 }}
        viewport={{ once: true }}
        transition={{ duration: 0.6 }}
        className="relative bg-white/5 backdrop-blur-sm rounded-3xl p-4 sm:p-6 lg:p-8 border border-white/10 overflow-hidden"
      >
        {/* Map Container */}
        <div className="relative w-full h-[300px] sm:h-[400px] lg:h-[500px]">
          <ComposableMap
            projectionConfig={{
              scale: isMobile ? 180 : 200,
              center: [0, 10],
            }}
            style={{ width: "100%", height: "100%" }}
          >
            <Geographies geography={geoUrl}>
              {({ geographies }) =>
                geographies.map((geo) => (
                  <Geography
                    key={geo.rsmKey}
                    geography={geo}
                    fill="rgba(168, 85, 247, 0.15)"
                    stroke="rgba(168, 85, 247, 0.4)"
                    strokeWidth={1}
                    style={{
                      default: {
                        outline: "none",
                      },
                      hover: {
                        fill: "rgba(168, 85, 247, 0.25)",
                        outline: "none",
                      },
                      pressed: {
                        outline: "none",
                      },
                    }}
                  />
                ))
              }
            </Geographies>
            {/* Markers for countries with users */}
            {countryMarkers.map((marker, index) => (
              <Marker
                key={index}
                coordinates={marker.coordinates}
                onMouseEnter={() => setSelectedMarker(index)}
                onMouseLeave={() => setSelectedMarker(null)}
              >
                <circle
                  r={selectedMarker === index ? (isMobile ? 6 : 8) : (isMobile ? 4 : 6)}
                  fill="#a855f7"
                  stroke="#fff"
                  strokeWidth={isMobile ? 1.5 : 2}
                  style={{
                    cursor: "pointer",
                    transition: "all 0.2s",
                  }}
                />
              </Marker>
            ))}
          </ComposableMap>
        </div>

        {/* Hover Tooltip */}
        {selectedMarker !== null && (
          <motion.div
            initial={{ opacity: 0, y: 10, x: "-50%" }}
            animate={{ opacity: 1, y: 0, x: "-50%" }}
            style={{ 
              position: 'absolute',
              bottom: '1rem',
              left: '50%',
            }}
            className="bg-white/10 backdrop-blur-md rounded-xl px-4 py-2 sm:px-6 sm:py-3 border border-white/20 z-10"
          >
            <div className="text-white font-semibold text-sm sm:text-lg text-center whitespace-nowrap">
              {countryMarkers[selectedMarker].name}
            </div>
          </motion.div>
        )}
      </motion.div>
    </div>
  );
}
