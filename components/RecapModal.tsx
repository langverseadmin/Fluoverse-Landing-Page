"use client";

import { motion, AnimatePresence } from "framer-motion";
import RecapEmbedded, { RecapEmbeddedData } from "./RecapEmbedded";
import { X } from "lucide-react";

interface RecapModalProps {
  data: RecapEmbeddedData;
  isOpen: boolean;
  onClose: () => void;
  onComplete?: () => void;
}

export default function RecapModal({ data, isOpen, onClose, onComplete }: RecapModalProps) {
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
            className="fixed inset-0 z-50 flex items-center justify-center p-4"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="relative w-full max-w-md h-[90vh] rounded-2xl overflow-hidden shadow-2xl">
              <RecapEmbedded
                data={data}
                onClose={onClose}
                onComplete={() => {
                  onComplete?.();
                  // Auto-close after a delay if onComplete is called
                  setTimeout(() => onClose(), 2000);
                }}
                autoPlay={true}
                className="h-full rounded-2xl"
              />
            </div>
          </motion.div>
        </>
      )}
    </AnimatePresence>
  );
}


