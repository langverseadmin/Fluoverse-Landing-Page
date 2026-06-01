import type { GuideFaqItem } from "@/lib/guides/types";

type GuideSchemaProps = {
  schemas: Record<string, unknown>[];
};

export default function GuideSchema({ schemas }: GuideSchemaProps) {
  return (
    <>
      {schemas.map((schema, index) => (
        <script
          key={index}
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(schema) }}
        />
      ))}
    </>
  );
}

export type { GuideFaqItem };
