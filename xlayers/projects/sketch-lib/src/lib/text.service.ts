import { Injectable } from '@angular/core';
import { BplistService } from './bplist.service';

@Injectable({
  providedIn: 'root'
})
export class TextService {
  constructor(private binaryHelperService: BplistService) {}

  identify(current: SketchMSLayer) {
    return (current._class as string) === 'text';
  }

  lookup(current: SketchMSLayer) {
    return (
      current.attributedString.string ||
      this.extractAttributedStringText(current)
    );
  }

  private extractAttributedStringText(current: SketchMSLayer) {
    const obj = current.attributedString;

    if (obj && obj.hasOwnProperty('archivedAttributedString')) {
      const archive = this.binaryHelperService.parse64Content(
        obj.archivedAttributedString._archive
      );

      if (archive) {
        return this.decodeArchiveString(archive);
      }
    }

    return '';
  }

  private decodeArchiveString(archive) {
    switch (archive.$key) {
      case 'ascii':
        return archive.$value;
      default:
        return '';
    }
  }
}
