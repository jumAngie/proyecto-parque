import { Component, ElementRef, OnInit } from '@angular/core';
import { Ticket } from 'src/app/Models/Tikectks';
import { ParqServicesService } from 'src/app/ParqServices/parq-services.service';
import { Router } from '@angular/router';


@Component({
  selector: 'app-listtickets',
  templateUrl: './listtickets.component.html',
  styleUrls: ['./listtickets.component.css']
})
export class ListticketsComponent {
  ticket!: Ticket[];
  constructor(
    private service:ParqServicesService, 
    private elementRef: ElementRef, 
    private router:Router
    ) { }

    ngOnInit(): void {
     this.ticketList(); 
    }

    // CARGAR DATITOS //
    ticketList(){
      this.service.getTicket()
    .subscribe((response: any) => {
      if (response.success) {
        this.ticket = response.data;
        console.log(this.ticket);
      }
    });
    }

     showImagePreview(imageUrl: string) {
      const modal = document.getElementById("imagePreviewModal");
      const previewImage = document.getElementById("previewImage") as HTMLImageElement;
    
      if (modal && previewImage) {
        previewImage.src = imageUrl;
        modal.style.display = "block";
      }
    }
    
     closeImagePreview() {
      const modal = document.getElementById("imagePreviewModal");
    
      if (modal) {
        modal.style.display = "none";
      }
    }
    
}
