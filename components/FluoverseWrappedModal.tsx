"use client";

import { motion, AnimatePresence } from "framer-motion";
import FluoverseWrapped, { FluoverseWrappedData } from "./FluoverseWrapped";

interface FluoverseWrappedModalProps {
  data: FluoverseWrappedData;
  isOpen: boolean;
  onClose: () => void;
  onComplete?: () => void;
  onScenarioSelect?: (lessonId: string) => void;
  selectedScenarioId?: string;
  captureMode?: boolean;
}

export default function FluoverseWrappedModal({ 
  data, 
  isOpen, 
  onClose, 
  onComplete,
  onScenarioSelect,
  selectedScenarioId,
  captureMode = false
}: FluoverseWrappedModalProps) {
  return (
    <AnimatePresence>
      {isOpen && (
        <>
          {/* Backdrop */}
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            onClick={onClose}
            className="fixed inset-0 bg-black/80 backdrop-blur-sm z-50"
          />
          
          {/* Modal */}
          <motion.div
            initial={{ opacity: 0, scale: 0.9, y: 20 }}
            animate={{ opacity: 1, scale: 1, y: 0 }}
            exit={{ opacity: 0, scale: 0.9, y: 20 }}
            transition={{ type: "spring", duration: 0.5 }}
            className="fixed inset-0 z-50 flex items-stretch justify-center p-0 md:items-center md:p-4"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="relative w-screen h-[100dvh] overflow-hidden shadow-none md:w-full md:max-w-md md:h-[90vh] md:rounded-2xl md:shadow-2xl">
              <FluoverseWrapped
                data={data}
                onClose={onClose}
                onComplete={() => {
                  onComplete?.();
                  setTimeout(() => onClose(), 2000);
                }}
                onScenarioSelect={onScenarioSelect}
                selectedScenarioId={selectedScenarioId}
                autoPlay={true}
                captureMode={captureMode}
                className="h-full md:rounded-2xl"
              />
            </div>
          </motion.div>
        </>
      )}
    </AnimatePresence>
  );
}


