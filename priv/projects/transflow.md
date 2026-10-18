%{
  title: "TransFlow: Enterprise AI Document Translation",
  description: "Document translation platform with multi-provider AI orchestration and preservation of complex document formats.",
  tags: ["elixir", "ai", "enterprise"],
  tech: ["Elixir", "Phoenix", "Java", "DeepSeek", "Gemini", "OpenAI", "MinIO", "Redis"],
  date: ~D[2025-03-01],
  featured: true,
  status: "development",
  metrics: [
    %{label: "AI Providers", value: "5+"},
    %{label: "Supported Formats", value: "PDF, DOCX, XLSX, PPTX"},
    %{label: "Failover", value: "Automatic"}
  ],
  hero_image: nil
}
---

I am building TransFlow as an enterprise document translation platform. It handles complex formats: PDFs with tables and images, Word documents with tracked changes, Excel spreadsheets with formulas and PowerPoint presentations with embedded media. The original structure and formatting are preserved through translation.

The main challenge is that enterprise documents are not flat text. A legal contract in PDF has headers, footers, tables, numbered clauses and specific formatting that must survive translation. Traditional translation tools either strip the formatting or produce garbled output. TransFlow separates document parsing from translation and handles each with its own component.

An Elixir/Phoenix backend handles orchestration and API management, and a Java microservice handles document parsing. The Java service uses iText for PDF manipulation and Apache POI for Microsoft Office formats, and extracts translatable segments along with document structure metadata. The Elixir layer routes those segments through the AI translation pipeline and reassembles the final document.

Multi-provider orchestration is central to reliability and cost. I integrated five AI providers, including DeepSeek, Gemini and OpenAI, with automatic fallback when a provider is unavailable or returns low-quality results. The system evaluates translation quality as it runs and can re-route mid-document. Redis caches frequently translated segments and manages session state, and MinIO stores the document files.

Authentication is session-based, and all translation activity has a full audit trail. The platform is designed for the volume and compliance requirements of enterprise clients.
