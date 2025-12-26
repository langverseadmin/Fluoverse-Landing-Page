import Navigation from "@/components/Navigation";
import Footer from "@/components/Footer";
import PrivacyContent from "./PrivacyContent";

export default function PrivacyPage() {
  return (
    <main className="min-h-screen">
      <Navigation />
      <div className="pt-24 pb-16 px-4 sm:px-6 lg:px-8">
        <div className="max-w-4xl mx-auto">
          <PrivacyContent />
        </div>
      </div>
      <Footer />
    </main>
  );
}
