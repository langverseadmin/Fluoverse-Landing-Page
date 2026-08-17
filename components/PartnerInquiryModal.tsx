"use client";

import { useEffect, useId, useState } from "react";
import { AnimatePresence, motion } from "framer-motion";
import { X } from "lucide-react";
import { trackPartnerCtaClick } from "@/lib/analytics";

const PARTNER_TYPES = [
  "Venues & event hosts",
  "Relocation & mobility",
  "Schools & communities",
  "Other",
] as const;

type FormState = {
  name: string;
  email: string;
  organisation: string;
  partnerType: string;
  location: string;
  message: string;
};

const emptyForm: FormState = {
  name: "",
  email: "",
  organisation: "",
  partnerType: "",
  location: "",
  message: "",
};

type PartnerInquiryModalProps = {
  open: boolean;
  onClose: () => void;
};

export default function PartnerInquiryModal({ open, onClose }: PartnerInquiryModalProps) {
  const titleId = useId();
  const [form, setForm] = useState<FormState>(emptyForm);
  const [status, setStatus] = useState<{ type: "success" | "error" | null; message: string }>({
    type: null,
    message: "",
  });
  const [isLoading, setIsLoading] = useState(false);

  useEffect(() => {
    if (!open) return;

    const previousOverflow = document.body.style.overflow;
    document.body.style.overflow = "hidden";

    const onKeyDown = (event: KeyboardEvent) => {
      if (event.key === "Escape") onClose();
    };
    window.addEventListener("keydown", onKeyDown);

    return () => {
      document.body.style.overflow = previousOverflow;
      window.removeEventListener("keydown", onKeyDown);
    };
  }, [open, onClose]);

  useEffect(() => {
    if (!open) {
      setStatus({ type: null, message: "" });
      setIsLoading(false);
    }
  }, [open]);

  const handleChange = (
    e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement | HTMLSelectElement>,
  ) => {
    setForm((prev) => ({ ...prev, [e.target.name]: e.target.value }));
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (!form.name || !form.email || !form.organisation || !form.partnerType || !form.location) {
      setStatus({
        type: "error",
        message: "Please fill in all required fields.",
      });
      return;
    }

    setIsLoading(true);
    setStatus({ type: null, message: "" });
    trackPartnerCtaClick();

    try {
      const response = await fetch("/api/contact", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          name: form.name.trim(),
          email: form.email.trim(),
          subject: "Partnership Inquiry",
          message: form.message.trim() || "I'd like to explore a partnership.",
          organisation: form.organisation.trim(),
          partnerType: form.partnerType,
          location: form.location.trim(),
          source: "become-a-partner",
        }),
      });

      const data = (await response.json()) as {
        success?: boolean;
        message?: string;
        error?: string;
      };

      if (!response.ok || !data.success) {
        setStatus({
          type: "error",
          message: data.error || data.message || "Something went wrong. Please try again.",
        });
        return;
      }

      setStatus({
        type: "success",
        message: data.message || "Thank you! Your message has been sent successfully.",
      });
      setForm(emptyForm);
    } catch {
      setStatus({
        type: "error",
        message: "Failed to send. Please check your connection and try again.",
      });
    } finally {
      setIsLoading(false);
    }
  };

  const fieldClass =
    "w-full px-4 py-3 bg-white/5 border border-white/10 rounded-xl text-white placeholder:text-white/40 focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all duration-300 disabled:opacity-50 disabled:cursor-not-allowed";

  return (
    <AnimatePresence>
      {open && (
        <>
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            className="fixed inset-0 z-[60] bg-black/70 backdrop-blur-sm"
            onClick={onClose}
            aria-hidden
          />

          <motion.div
            role="dialog"
            aria-modal="true"
            aria-labelledby={titleId}
            initial={{ opacity: 0, scale: 0.96, y: 16 }}
            animate={{ opacity: 1, scale: 1, y: 0 }}
            exit={{ opacity: 0, scale: 0.96, y: 16 }}
            transition={{ duration: 0.25 }}
            className="fixed inset-0 z-[70] flex items-end justify-center p-0 sm:items-center sm:p-4"
            onClick={onClose}
          >
            <div
              className="relative max-h-[92vh] w-full overflow-y-auto rounded-t-3xl border border-white/10 bg-[#2a0f42] p-5 shadow-2xl sm:max-w-lg sm:rounded-3xl sm:p-7"
              onClick={(e) => e.stopPropagation()}
            >
              <button
                type="button"
                onClick={onClose}
                className="absolute right-4 top-4 rounded-full p-2 text-white/70 transition-colors hover:bg-white/10 hover:text-white"
                aria-label="Close partnership form"
              >
                <X className="h-5 w-5" />
              </button>

              <div className="pr-10">
                <h3 id={titleId} className="text-2xl font-bold text-white">
                  Become a Partner
                </h3>
                <p className="mt-2 text-sm leading-relaxed text-white/70">
                  Tell us who you are and where you operate. We will follow up with next steps.
                </p>
              </div>

              <form onSubmit={handleSubmit} className="mt-6 space-y-4" noValidate>
                <div>
                  <label htmlFor="partner-name" className="mb-2 block text-sm font-medium text-white/90">
                    Name
                  </label>
                  <input
                    id="partner-name"
                    name="name"
                    type="text"
                    value={form.name}
                    onChange={handleChange}
                    required
                    disabled={isLoading}
                    className={fieldClass}
                    placeholder="Your name"
                    autoComplete="name"
                  />
                </div>

                <div>
                  <label htmlFor="partner-email" className="mb-2 block text-sm font-medium text-white/90">
                    Email
                  </label>
                  <input
                    id="partner-email"
                    name="email"
                    type="email"
                    value={form.email}
                    onChange={handleChange}
                    required
                    disabled={isLoading}
                    className={fieldClass}
                    placeholder="you@company.com"
                    autoComplete="email"
                  />
                </div>

                <div>
                  <label
                    htmlFor="partner-organisation"
                    className="mb-2 block text-sm font-medium text-white/90"
                  >
                    Organisation
                  </label>
                  <input
                    id="partner-organisation"
                    name="organisation"
                    type="text"
                    value={form.organisation}
                    onChange={handleChange}
                    required
                    disabled={isLoading}
                    className={fieldClass}
                    placeholder="Company or venue name"
                    autoComplete="organization"
                  />
                </div>

                <div>
                  <label
                    htmlFor="partner-type"
                    className="mb-2 block text-sm font-medium text-white/90"
                  >
                    Partner type
                  </label>
                  <select
                    id="partner-type"
                    name="partnerType"
                    value={form.partnerType}
                    onChange={handleChange}
                    required
                    disabled={isLoading}
                    className={`${fieldClass} appearance-none`}
                  >
                    <option value="" disabled className="bg-[#2a0f42] text-white">
                      Select one
                    </option>
                    {PARTNER_TYPES.map((type) => (
                      <option key={type} value={type} className="bg-[#2a0f42] text-white">
                        {type}
                      </option>
                    ))}
                  </select>
                </div>

                <div>
                  <label
                    htmlFor="partner-location"
                    className="mb-2 block text-sm font-medium text-white/90"
                  >
                    City & country
                  </label>
                  <input
                    id="partner-location"
                    name="location"
                    type="text"
                    value={form.location}
                    onChange={handleChange}
                    required
                    disabled={isLoading}
                    className={fieldClass}
                    placeholder="Madrid, Spain"
                    autoComplete="address-level2"
                  />
                </div>

                <div>
                  <label
                    htmlFor="partner-message"
                    className="mb-2 block text-sm font-medium text-white/90"
                  >
                    Message <span className="text-white/40">(optional)</span>
                  </label>
                  <textarea
                    id="partner-message"
                    name="message"
                    rows={4}
                    value={form.message}
                    onChange={handleChange}
                    disabled={isLoading}
                    className={`${fieldClass} resize-none`}
                    placeholder="Anything we should know before we reach out?"
                  />
                </div>

                {status.message && (
                  <div
                    className={`rounded-xl p-3 text-sm ${
                      status.type === "success"
                        ? "border border-green-500/30 bg-green-500/20 text-green-300"
                        : "border border-red-500/30 bg-red-500/20 text-red-300"
                    }`}
                  >
                    {status.message}
                  </div>
                )}

                <button
                  type="submit"
                  disabled={isLoading}
                  className="neon-cta-3d flex w-full justify-center px-6 py-3.5 text-sm font-semibold text-white disabled:cursor-not-allowed disabled:opacity-60"
                >
                  {isLoading ? "Sending..." : "Send partnership inquiry"}
                </button>
              </form>
            </div>
          </motion.div>
        </>
      )}
    </AnimatePresence>
  );
}
