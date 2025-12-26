"use client";

import { useEffect, useState } from "react";

export default function TermsContent() {
  const [content, setContent] = useState<string>("");

  useEffect(() => {
    fetch("/assets/Terms.md")
      .then((res) => res.text())
      .then((text) => setContent(text))
      .catch(() => setContent("Terms and conditions content not available."));
  }, []);

  // Simple markdown to HTML converter
  const formatMarkdown = (md: string) => {
    let html = md;
    
    // Headers
    html = html.replace(/^# (.+)$/gm, '<h1 class="text-4xl font-bold text-white mb-6 mt-12 first:mt-0">$1</h1>');
    html = html.replace(/^## (.+)$/gm, '<h2 class="text-3xl font-bold text-white mt-12 mb-4">$1</h2>');
    html = html.replace(/^### (.+)$/gm, '<h3 class="text-2xl font-semibold text-white mt-8 mb-3">$1</h3>');
    html = html.replace(/^#### (.+)$/gm, '<h4 class="text-xl font-semibold text-white mt-6 mb-2">$1</h4>');
    
    // Bold
    html = html.replace(/\*\*(.+?)\*\*/g, '<strong class="font-semibold text-white">$1</strong>');
    
    // Links
    html = html.replace(/\[([^\]]+)\]\(([^)]+)\)/g, '<a href="$2" class="text-purple-400 hover:text-purple-300 underline">$1</a>');
    
    // Lists - handle both - and numbered
    html = html.replace(/^- (.+)$/gm, '<li class="ml-6 mb-2 text-white/80">$1</li>');
    html = html.replace(/^\d+\. (.+)$/gm, '<li class="ml-6 mb-2 text-white/80">$1</li>');
    
    // Wrap consecutive list items in ul
    html = html.replace(/(<li.*<\/li>\n?)+/g, (match) => {
      return `<ul class="list-disc mb-4 space-y-1">${match}</ul>`;
    });
    
    // Horizontal rules
    html = html.replace(/^---$/gm, '<hr class="border-white/10 my-8" />');
    
    // Blockquotes
    html = html.replace(/^> (.+)$/gm, '<blockquote class="border-l-4 border-purple-500 pl-4 italic text-white/70 my-4">$1</blockquote>');
    
    // Paragraphs - split by double newlines
    const sections = html.split('\n\n');
    html = sections.map(section => {
      const trimmed = section.trim();
      if (!trimmed || trimmed.startsWith('<')) return trimmed;
      return `<p class="text-white/80 leading-relaxed mb-4">${trimmed}</p>`;
    }).join('\n\n');
    
    // Clean up extra newlines
    html = html.replace(/\n{3,}/g, '\n\n');
    
    return html;
  };

  if (!content) {
    return (
      <div className="text-center py-12">
        <p className="text-white/70">Loading terms and conditions...</p>
      </div>
    );
  }

  const formattedContent = formatMarkdown(content);

  return (
    <div 
      className="prose prose-invert prose-purple max-w-none"
      dangerouslySetInnerHTML={{ __html: formattedContent }}
    />
  );
}

