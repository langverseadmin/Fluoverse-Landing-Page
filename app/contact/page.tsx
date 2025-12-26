import Navigation from "@/components/Navigation";
import Footer from "@/components/Footer";
import ContactForm from "./ContactForm";

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
              Have a question? We'd love to hear from you.
            </p>
          </div>
          <ContactForm />
        </div>
      </div>
      <Footer />
    </main>
  );
}

