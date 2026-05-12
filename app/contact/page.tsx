import type { Metadata } from "next";
import Navigation from "@/components/Navigation";
import Footer from "@/components/Footer";
import ContactForm from "./ContactForm";

export const metadata: Metadata = {
  title: "Contact",
  description:
    "Contact Fluoverse — collaborations that help arrivals connect with locals, relocation & friendship initiatives, partnerships, press, and learner questions.",
  alternates: { canonical: "https://fluoverse.com/contact" },
  openGraph: {
    url: "https://fluoverse.com/contact",
    title: "Contact | Fluoverse",
    description: "Questions about bridging language gaps, partnerships, or help connecting abroad—say hello here.",
  },
};

export default function ContactPage() {
  return (
    <main className="min-h-screen">
      <Navigation />
      <div className="pt-24 pb-16 px-4 sm:px-6 lg:px-8">
        <div className="max-w-2xl mx-auto">
          <div className="text-center mb-12">
            <h1 className="text-4xl sm:text-5xl font-bold text-white mb-4">
              Get in <span className="text-purple-400">Touch</span>
            </h1>
            <p className="text-white/70 text-lg">
              Have a question? We&apos;d love to hear from you.
            </p>
          </div>
          <ContactForm />
        </div>
      </div>
      <Footer />
    </main>
  );
}
