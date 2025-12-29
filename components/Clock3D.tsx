"use client";

import { useEffect, useRef } from "react";

interface Clock3DProps {
  value: number;
  className?: string;
}

// Component for a single 3D digit
const Digit3D = ({ digit }: { digit: string }) => (
  <div className="clock-digit" data-digit={digit}>
    <span className="end top"></span>
    <span className="side left top"></span>
    <span className="side right top"></span>
    <span className="middle"></span>
    <span className="side left bottom"></span>
    <span className="side right bottom"></span>
    <span className="end bottom"></span>
  </div>
);

export default function Clock3D({ value, className = "" }: Clock3DProps) {
  const wrapperRef = useRef<HTMLDivElement>(null);

  // Format value to always show at least 3 digits (e.g., "021" for 21)
  const formattedValue = String(value).padStart(3, '0');
  const digits = formattedValue.split('');

  return (
    <div 
      ref={wrapperRef}
      className={`clock-wrapper ${className}`}
      style={{
        fontSize: 'clamp(0.2rem, 1vw, 0.5rem)',
        width: '100%',
        height: '100%',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
      }}
    >
      <div className="clock-main">
        <div className="clock-digits">
          <div className="clock-group">
            {digits.map((digit, index) => (
              <Digit3D key={`digit-${index}-${digit}`} digit={digit} />
            ))}
          </div>
        </div>
        
        {/* Shadows for 3D effect */}
        <div className="clock-shadow shadow1">
          <div className="clock-digits">
            <div className="clock-group">
              {digits.map((digit, index) => (
                <div key={`shadow1-${index}-${digit}`} className="clock-digit" data-digit={digit}>
                  <span className="end top"></span>
                  <span className="side left top"></span>
                  <span className="side right top"></span>
                  <span className="middle"></span>
                  <span className="side left bottom"></span>
                  <span className="side right bottom"></span>
                  <span className="end bottom"></span>
                </div>
              ))}
            </div>
          </div>
        </div>
        
        <div className="clock-shadow shadow2">
          <div className="clock-digits">
            <div className="clock-group">
              {digits.map((digit, index) => (
                <div key={`shadow2-${index}-${digit}`} className="clock-digit" data-digit={digit}>
                  <span className="end top"></span>
                  <span className="side left top"></span>
                  <span className="side right top"></span>
                  <span className="middle"></span>
                  <span className="side left bottom"></span>
                  <span className="side right bottom"></span>
                  <span className="end bottom"></span>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

