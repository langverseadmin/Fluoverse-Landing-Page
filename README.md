# Fluoverse Company Website

A modern, professional website built with Next.js, TypeScript, and TailwindCSS for Fluoverse - a language learning platform.

## 🚀 Features

- **Modern Design**: Clean, professional, and impressive UI
- **Fully Responsive**: Works perfectly on all devices
- **Smooth Animations**: Powered by Framer Motion
- **SEO Optimized**: Built-in metadata and Open Graph tags
- **Fast Performance**: Optimized with Next.js 14
- **Type Safe**: Full TypeScript support

## 🛠️ Tech Stack

- **Next.js 14** - React framework with App Router
- **TypeScript** - Type-safe development
- **TailwindCSS** - Utility-first CSS framework
- **Framer Motion** - Smooth animations
- **Lucide React** - Beautiful icons

## 📦 Installation

1. Install dependencies:
```bash
npm install
```

2. Run the development server:
```bash
npm run dev
```

3. Open [http://localhost:3000](http://localhost:3000) in your browser

## 🏗️ Project Structure

```
├── app/
│   ├── layout.tsx       # Root layout with metadata
│   ├── page.tsx         # Homepage
│   └── globals.css      # Global styles
├── components/
│   ├── Navigation.tsx    # Header navigation
│   ├── Hero.tsx         # Hero section
│   ├── Features.tsx     # Features showcase
│   ├── HowItWorks.tsx   # How it works section
│   ├── Testimonials.tsx # User testimonials
│   ├── CTA.tsx          # Call-to-action section
│   └── Footer.tsx       # Footer component
└── public/              # Static assets
```

## 🎨 Customization

### Colors

Edit `tailwind.config.ts` to customize the color scheme:

```typescript
colors: {
  primary: { ... },  // Main brand color
  accent: { ... },   // Accent color
}
```

### Content

Update content in each component file:
- `components/Hero.tsx` - Hero section content
- `components/Features.tsx` - Feature cards
- `components/Testimonials.tsx` - Testimonials

### Metadata

Edit `app/layout.tsx` to update SEO metadata and Open Graph tags.

## 🚢 Deployment

### Vercel (Recommended)

1. Push your code to GitHub
2. Import your repository in [Vercel](https://vercel.com)
3. Deploy with one click

### Other Platforms

```bash
npm run build
npm start
```

## 📝 License

This project is proprietary and confidential.

## 👥 Team

Built with ❤️ for Fluoverse
